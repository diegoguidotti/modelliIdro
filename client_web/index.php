<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="scripts/OpenLayers/OpenLayers.js"></script>
<script src="scripts/modelli_idro.js"></script>
<script type="text/javascript" src="http://maps.stamen.com/js/tile.stamen.js"></script>
</head>
<body onLoad="init()">

<style>

#container {
	width:720px;
	height:400px;
	float:left; 
}

#map {
	width:600px;
	height:600px;
	float:left;
}

#legend {
        width:120px;
	float:right;
	
}
</style>


<div id="container">
	<div id="control">

		<select id="tipo_mappa" onChange="updateMap()">
			<option value="tempsuolo">Temperatura del Suolo</option>
			<option value="evapotras">Evapotraspirazione</option>
			<option value="satusuolo">Saturazione del Suolo</option>
		</select>

		<select id="Bacino" onChange="updateMap()">
			<option value="CECINA">Cecina</option>
		</select>

		<select id="Modello" name="Modello" onchange="setModel()">
			<option value="qm_lami08">LAMI</option>
			<option value="qm_arw_ecm_">ARW ECM</option>
		</select>

	</div>

	<div id="map"></div>
	<div id="legend"></div>
</div>


</body>
</html>
