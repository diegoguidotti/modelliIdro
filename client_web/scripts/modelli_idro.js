var map, layer, network;
var proj_4326 = new OpenLayers.Projection("EPSG:4326");
var proj_900913 = new OpenLayers.Projection("EPSG:900913")

var default_point = new OpenLayers.LonLat(11,43.43);
var default_zoom = 8;

var base_url='/cgi-bin/mapserv';
var mapfile_path='/opt/modelli_idro/mapfile/';


function init(){
   var options = {
      projection: proj_900913,
      displayProjection: proj_4326,
      units: "m",
      numZoomLevels: 18,
      maxResolution: 156543.0339,
      maxExtent: new OpenLayers.Bounds(-20037508, -20037508,20037508, 20037508.34)
   };
   map = new OpenLayers.Map('map',options);

   ls=new OpenLayers.Control.LayerSwitcher();
   map.addControl(ls);


		var toner = new OpenLayers.Layer.Stamen("toner");
		map.addLayers([toner]);

		var url=getUrl();function setModel(){
   var url = getUrlNetwork();
   if(url != null){
      network.setVisibility(true);
      network.url = url;
      network.redraw();
      getData('type');
   }
}


		//add the layer with moodel results
		layer = new OpenLayers.Layer.WMS("Riisultato Modelli",url,{layers:'tempsuolo',format:'image/png',TRANSPARENT:true},{'buffer':0,isBaseLayer:false, visibility:true});
		layer.setOpacity(0.5);
		map.addLayer(layer);

		//add the netwoork layer (invisible by default)
		var nt_url = getUrlNetwork();
		network = new OpenLayers.Layer.WMS("Rete",nt_url,{layers:'data',format:'image/png',TRANSPARENT:true},{'buffer':0,isBaseLayer:false,visibility:true});
		network.setOpacity(0.7);
		map.addLayer(network);

		map.moveTo(default_point.transform(proj_4326,map.getProjectionObject()),default_zoom); 	
}


function addLoadingEvent(l){
	l.events.register("loadstart", l, function (e) {
		load_tile(true);
    });    
	l.events.register("loadend", l, function (e) {
		load_tile(false);
    });    
}

function load_tile (loading_status) {
		
	if(loading_status){
		jQuery("#loading").show();
	}
	else {
		jQuery("#loading").hide();
	}
}


function updateMap(){
	var u=getUrl();
	if(u!=null){
		layer.setVisibility(true);
	  layer.url = u;
		layer.mergeNewParams({layers : document.getElementById('tipo_mappa').value });
	  layer.redraw();
	}
}


//Execute after a model has been chosed
function setModel(){
   var url = getUrlNetwork();
   if(url != null){
      network.setVisibility(true);
      network.url = url;
      network.redraw();
      getData('type');
   }
}


//Return the URL for model mapfiles
function getUrl(){
	 var type=document.getElementById('tipo_mappa').value;
	 var b=document.getElementById('Bacino').value;
	 raster_theme=type.toUpperCase()+"_MOBIDIC_"+b.toUpperCase()+".tif";

   var url_legend=base_url+'?map='+mapfile_path+'modelli.map&VERSION=1.1.1&LAYER='+type+'&FORMAT=image%2Fpng&SERVICE=WMS&REQUEST=GetLegendGraphic';
 	 document.getElementById('legend').innerHTML='<h3>Legenda</h3><img src="'+url_legend+'" />';
    var url = base_url;
		url += '?map='+mapfile_path + 'modelli.map&VERSION=1.1.1&raster_theme=' + raster_theme;
   	return url;	
}

//Return the URL for network mapfiles
function getUrlNetwork(){
   var b = document.getElementById('Bacino').value.replace('OMBRONE','OMBRONE_GR');
   var m = document.getElementById('Modello').value;
   m = ((m.length > 0)?m:default_model);

   var url = base_url;
   url += '?map='+mapfile_path+'network.map&VERSION=1.1.1';
   url += '&model_type=' + m + '&bacino=' + b.toLowerCase();

   return url;
}

