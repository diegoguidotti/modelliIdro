#!/bin/bash

#Custom Parameter
modelli_path=/opt/modelli_idro   #path containing the script
input_folder=input_dir           #name of the folder within the path containing the input dile
db_user=gis                      #name of the database
db_name=cf                       #name of the postgres user
srid=903003											 #spatial reference adopted by shapefile 903003 is a modification of 3003 (Gauss Boaga Italia coordinates West)

cd $modelli_path/working/


input_files=$modelli_path/$input_folder/*.tar

count=`ls -1 $input_files 2>/dev/null | wc -l`
echo "There are "$count" files to be elaborated "

#Check if at least one file exists
if [ $count != 0 ];
then
  #Scan all the tar files in the folder
	for fl in $input_files; do
		echo " Working on file: "$fl
		fn=`basename $fl`

		cp $fl $modelli_path/working/
		tar xvf   $modelli_path/working/$fn >/dev/null
		

		count_img=`ls -1 $modelli_path/working/*.tif 2>/dev/null | wc -l`
	
    if [ $count_img != 0 ];
		then

		  for fl2 in $modelli_path/working/*.tif; do
				
				fn2=`basename $fl2`

				#extract data from file
				new_name=${fn2:0: ${#fn2}-16 }
				res=${fn2:${#fn2}-8: 4}
				dd=${fn2:${#fn2}-15: 2}
				mm=${fn2:${#fn2}-13: 2}
				yy=${fn2:${#fn2}-11: 2}


				prod=${fn2:0: 9}
				area=${fn2:18: ${#fn2}-34}
				echo "   Image:" $res $dd $mm $yy $prod $area

				rm $modelli_path/raster/$new_name.tif
				mv $fl2 $modelli_path/raster/$new_name.tif
				
				psql -h 127.0.0.1 -U $db_user -d $db_name -c "DELETE from modelli_idro.prodotti WHERE produttore='mobidic' AND tipo_prodotto='$prod' AND area='$area' ;" >/dev/null

				psql -h 127.0.0.1 -U $db_user -d $db_name -c "insert into modelli_idro.prodotti (produttore, tipo_prodotto, area, res, time_ref, raster) VALUES ('mobidic','$prod','$area',$res, '20$yy-$mm-$dd','$new_name');" >/dev/null
				

				done #End of tif analysis
		fi 

		count_shp=`ls -1 $modelli_path/working/*.shp 2>/dev/null | wc -l`	
    if [ $count_shp != 0 ];
		then
			bacino=${fn:12: ${#fn}-16}
			bacino2=$(<<< $bacino tr [:lower:] [:upper:])

			#name fix for Regione Toscana
			if [ "$bacino2" == "OMBRONE" ]; then
				bacino2="OMBRONE_GR";
			fi		
			echo "Work on basin shapefile:" $bacino $bacino2

			#drop table (if exists)
			psql -h 127.0.0.1 -U $db_user -d $db_name -c "DROP TABLE IF EXISTS modelli_idro.mobidic_network_$bacino2;" >/dev/null
			#create script and drop table
			shp2pgsql -c -s $srid ret_$bacino2.shp modelli_idro.mobidic_network_$bacino2 > net$bacino2.sql
			psql -h 127.0.0.1 -U $db_user -d $db_name -f net$bacino2.sql > /dev/null

			#remove temporary files
			rm ret_$bacino2*
			rm net$bacino2.sql
			
		fi

		#remove temporary files
		rm $modelli_path/working/$fn
		rm $fl	
		

	done  #End of tar file analysis
else
   echo "There are no input files"
fi


