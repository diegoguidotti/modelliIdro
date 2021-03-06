The script take a tar file containing the results of hydrological models for  everal basin. The raster and vector data will be organised to be published in WMS using Mapserver.

Software Requisites
===================
  * Linux server (tested on Ubuntu)
	* PostgreSQL (>=8.4) and Postgis (>=1.5)
  * Apache2
  * Mapserver 5

1. Install and setup
--------------------

1.1. Clone thr project on a folder (standard folder will be /opt/modelli_idro/ )

1.2. Check if script can be executed (chmod +x exe_import.sh)

1.3. Modify (if needed) the standard parameters

*	modelli_path=/opt/modelli_idro   #path containing the script
*	input_folder=input_dir           #name of the folder within the path containing the input dile
*	db_user=gis                      #name of the database
*	db_name=cf                       #name of the postgres user
*	srid=903003			 #spatial reference adopted by shapefile 903003 is a modification of 3003 (Gauss Boaga Italia coordinates West)

2. Database setup
--------------------

2.1. Create a PostgresSQL database (>=8.4) with Postgis exabled (>=1.5) (the standard db name is cf and the user is gis) 

2.2. Execute create_schema.sql to create a modelli_idro schema with a service table

2.3. Make sure if the db user can access the database and can login without password (using ident or using .pgpass) 

2.4. Double check if user can access geometry_column and spatial_ref_system tables  

3. Mapserver setup
--------------------

3.1. Install mapserver, it should response on http://localhost/cgi-bin/mapserv

3.2. If data are in a different proojection you need to adapt the layers projection in mapfile

3.3. if db name and users are not cf/gis you need to change mapfile/network.map layer connection string


4. Run the scripts
--------------------

4.1 run test.sh to test the system using the sample data (test_data/mobidic_test_data.tar)

4.2 copy the real data in the input_dir folder

4.3 run exe_import.sh to test the import

4.4 add exe_import.sh to cron

The tar folder has to be transfered in the input_data folder and the exe_import.sh script has to lunched to prepare all the data. The test.sh script will test the system using some sample data 




5. Client app
--------------------

4.1 copy/link the client_web folder in apache htdocs folder 
4.2 edit client_web/modelli_idro.js to change mapfile_path if is not /otp/modelli_idro/mapfile/
4.3 change index.php to list basins and models (it will be generated querying the db)
