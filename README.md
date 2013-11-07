The script take a tar folder containing for several basins the results of several hydrological models. The reults can be geoTiff raster data and shapefile related to hydrological networks with some attributes related to the matematical simulation.





Software Requisites
===================
  * Linux server (tested on Ubuntu)
	* PostgreSQL (>=8.4) and Postgis (>=1.5)
  * Apache2
  * Mapserver 5

1. Install and setup
--------------------

1.1 Clone thr project on a folder (standard folder will be /opt/modelli_idro/ )
1.2 Check if script can be executed (chmod +x exe_import.sh)
1.3 Modify (if needed) the standard parameters
	modelli_path=/opt/modelli_idro   #path containing the script
	input_folder=input_dir           #name of the folder within the path containing the input dile
	db_user=gis                      #name of the database
	db_name=cf                       #name of the postgres user
  srid=903003											 #spatial reference adopted by shapefile 903003 is a modification of 3003 (Gauss Boaga Italia coordinates West)


2. Database setup
--------------------

2.1 Create a PostgresSQL database (>=8.4) with Postgis exabled (>=1.5) (the standard db name is cf and the user is gis) 
2.2 Execute create_schema.sql to create a modelli_idro schema with a service table
2.3 Make sure if the db user can access the database and can login without password (using ident or using .pgpass) 
2.4 Double check if user can access geometry_column and spatial_ref_system tables  

3. Mapserver setup
--------------------

3.1 Install mapserver, it should response on http://localhost/cgi-bin/mapserv
3.2 If data are in a different proojection you need to adapt the layers projection in mapfile
3.3 if db name and users are not cf/gis you need to change mapfile/network.map layer connection string


4. Client app
--------------------

4.1 copy/link the client_web folder in apache htdocs folder 
