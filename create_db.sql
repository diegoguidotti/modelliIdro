CREATE SCHEMA modelli_idro;

CREATE TABLE modelli_idro.prodotti
(
  produttore character varying,
  tipo_prodotto character varying,
  area character varying,
  time_ref timestamp with time zone,
  res double precision,
  raster character varying,
  id_prodotto serial NOT NULL,
  CONSTRAINT prodotti_pkey PRIMARY KEY (id_prodotto)
);


--create a new srid to amange Gauss Boaga with to_wgs84 parameters
insert into  spatial_ref_sys select 903003, 'AEDIT', 903003,srtext,proj4text FROM  spatial_ref_sys WHERE srid=3003;

UPDATE spatial_ref_sys SET srtext='PROJCS["Monte Mario / Italy zone 1",GEOGCS["Monte Mario",DATUM["Monte_Mario",SPHEROID["International 1924",6378388,297,AUTHORITY["EPSG","7022"]],TOWGS84[-104.1,-49.1,-9.9,0.971,-2.917,0.714,-11.68],AUTHORITY["EPSG","6265"]],PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],UNIT["degree",0.01745329251994328,AUTHORITY["EPSG","9122"]],AUTHORITY["EPSG","4265"]],PROJECTION["Transverse_Mercator"],PARAMETER["latitude_of_origin",0],PARAMETER["central_meridian",9],PARAMETER["scale_factor",0.9996],PARAMETER["false_easting",1500000],PARAMETER["false_northing",0],UNIT["metre",1,AUTHORITY["EPSG","9001"]],AUTHORITY["EPSG","3003"]]'
WHERE srid=903003 ;

UPDATE spatial_ref_sys SET proj4text='+proj=tmerc +lat_0=0 +lon_0=9 +k=0.999600 +x_0=1500000 +y_0=0 +ellps=intl +units=m +no_defs +towgs84=-104.1,-49.1,-9.9,0.971,-2.917,0.714,-11.68'
 WHERE "srid"=903003;

