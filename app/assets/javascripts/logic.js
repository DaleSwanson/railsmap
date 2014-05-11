//general map interaction logic, clicking the map and changing icons

var popuptext;
var changedPois = [];
var sideBar = document.getElementById('divRightBody');
var newPoiMode = 0;

function clickMarker(id, poi) {
	var lat = poi._latlng.lat;
	var long = poi._latlng.lng;
	
	toggleHighlight(poi);
	
	popuptext = poi.options.title + "; " + poi.options.height + " ft; " + lat + ", " + long;
	sideBar.innerHTML += "<br>" + poi.options.id+" "+popuptext;
	if (routeMode) {clickRoute(lat, long);}
}

function toggleHighlight(poi) {
	if (poi.options.highlightState)
	{//currently highlighted
		HighlightOff(poi);
	}
	else
	{//currently unhighlighted
		HighlightOn(poi);
	}	
}

function HighlightOn(poi) { //turn marker highlight on
	poi.setIcon(poi.options.highlightIcon);
	poi.options.highlightState = 1;
	changedPois.push(poi);
}

function HighlightOff(poi) { //turn marker highlight off
	poi.setIcon(poi.options.defaultIcon);
	poi.options.highlightState = 0;
}


function clearRoute() {
	sideBar.innerHTML = "";	
	map.closePopup();
	
	unhighlightRoute();
	unhighlightPois();
	endRoute();
}

function addPoint(jump) 
{
	var latLong = document.formHeader.latLongValue.value;
	var myRegexp = /(-?\d{1,3}\.?\d*)[^\d-]+(-?\d{1,3}\.?\d+)/;
	var match = myRegexp.exec(latLong);
	var lat = match[1];
	var long = match[2];
	
	var tempMarker = L.marker([lat, long], {icon: iconTemp}).addTo(map);
	if (jump) {map.panTo(new L.LatLng(lat, long));}
	
}

// Code for manually adding route data, should be temporary //
function log(id, routeName)
{
	var color = $('input[name=routeColor]:checked').val();
	var routeNum=document['form'+id].routeNum.value;
	var miles=document['form'+id].distance.value;
	var description=document['form'+id].description.value;
	
	feet = Math.round(miles * 5280)
	
	var requestUrl = '/maps/updateRoute/' + id + '/' + color + '/' + routeNum + '/' + feet + '/' + description;
	$.get(requestUrl, function(data){
		//alert("Color: "+color+" Route: "+routeNum);
	});
	
	if (color)
	{
		routeName.setStyle({ color: color });
	}
	map.closePopup();
}


function explode(id, route)
{
	//Test_dsc._latlngs[0].lat
	var numPoints = route._latlngs.length;
	var breakMarker = [];
	var lat, long;
	
	for (var i=0; i<numPoints; i++)
	{
		lat = route._latlngs[i].lat;
		long = route._latlngs[i].lng;
		
		breakMarker[i] = L.marker([lat, long], {icon: iconTemp}).bindPopup(
	
		"Route ID: "+id+" <br>lat: "+lat+" <br> long: "+long+" &nbsp;&nbsp;&nbsp;<br>"+
		"<input type='button' value='Break Here' onclick='breakRoute("+id+", "+lat+", "+long+")'>"+
		""
		).addTo(map);
	}
	map.closePopup();
}


function breakRoute(id, lat, long)
{
	var requestUrl = '/editroute/' + id + '/' + lat + '/' + long;
	$.get(requestUrl, function(data){
		//alert("Color: "+color+" Route: "+routeNum);
	});
	map.closePopup();
}

function togglePoiMode()
{
	newPoiMode = !newPoiMode;
}

function newPoi(lat, long, park)
{
	popupText = '';
	popupText += "Add a new POI at: " + lat + ", " + long + "<br>";
	
	popupText += "<form name='newPoiForm'> ";
	popupText += "<table>";
	popupText += "<tr><td>Name: </td><td><input type='text' name='nameBox' style='width:15em'></td></tr>";
	popupText += "<tr><td>Height: </td><td><input type='text' name='heightBox' style='width:10em'></td></tr>";
	popupText += "<tr><td>Description: </td><td><textarea name='description' rows='2'> </textarea>";
	popupText += "<tr><td>Type: </td><td><select id='newPoiTypeCombo' name='typeCombo'>";
	popupText += "<option value='7'>Other</option>";
	
	poiType.forEach(function(label, id)
	{
		popupText += "<option value='"+id+"'>"+label+"</option>";
	});
	popupText += "</select></td></tr>";
	popupText += "</table>";
	popupText += "<input type='button' value='Save' onclick='addNewPoi("+lat+","+long+","+park+")'>";
	popupText += "</form>";
	
	newPoiPopup.setLatLng([lat, long]);
	newPoiPopup.setContent(popupText);
	newPoiPopup.openOn(map);	
}


function getCurrentUrl()
{
	var zoom = map.getZoom();
	var lat = map.getCenter().lat.toFixed(4);
	var long = map.getCenter().lng.toFixed(4);
	
	var newUrl;
	var currentUrl = document.URL; //http://localhost:3000/maps/t/p?z=13&tr=1&colorize=1&jc=1
	var baseUrl = currentUrl.replace(/\?.*/,''); //strip out query string
	
	newUrl = baseUrl + "?z="+zoom+"&lat="+lat+"&long="+long
	//map.hasLayer(layerSummits)
	
	if (map.hasLayer(layerTrails)) {newUrl+='&tr=1';} else {newUrl+='&tr=0';}
	listLayers.forEach(function(i)
	{
		var thisLayerName = i;
		var thisParam = layerParams[thisLayerName];
		var thisLayer = window[thisLayerName]
		if (map.hasLayer(thisLayer)) {newUrl+='&'+thisParam+'=1';} else {newUrl+='&'+thisParam+'=0';}
	});
	if (currentUrl.indexOf('colorize=1') >= 0) {newUrl += '&colorize=1';}
	
	if (map.hasLayer(layerScans)) {newUrl+="&sc=1";} else {newUrl+="&sc=0";}      
	if (map.hasLayer(layerUsgs)) {newUrl+="&us=1";} else {newUrl+="&us=0";}      
	
	return newUrl;
}



function getLink()
{
	document.formHeader.linkBox.value = getCurrentUrl();
}



function savePoi(id)
{
	var type = $('input[name=poiType]:checked').val();
	var lat=document['poi'+id].latBox.value;
	var long=document['poi'+id].longBox.value;
	var height=document['poi'+id].heightBox.value;
	var name=document['poi'+id].nameBox.value;
	var poiObject = window["poi_"+id];
	
	
	var requestUrl = '/maps/savePoi/' + id + '/' + type + '/' + lat + '/' + long + '/' + height + '/' + name;
	$.get(requestUrl, function(data){
		//alert("Color: "+color+" Route: "+routeNum);
	});
	
	if (type == '1') {poiObject.setIcon(icon_TrailHeads);}
	else if (type == '2')	{poiObject.setIcon(icon_Summit);}
	else if (type == '3')	{poiObject.setIcon(icon_TentSite);}
	else if (type == '4')	{poiObject.setIcon(icon_Leanto);}
	else if (type == '5')	{poiObject.setIcon(icon_Junction);}
	else if (type == '7')	{poiObject.setIcon(icon_Other);}
	else if (type == '10')	{poiObject.setIcon(icon_View);}
	map.closePopup();
}

function addNewPoi(lat, long, park)
{
	//var type2 = document.newPoiForm.typeBox.value;
	var name = document.newPoiForm.nameBox.value;
	var desc = document.newPoiForm.description.value;
	var height = document.newPoiForm.heightBox.value;
	var type = document.getElementById('newPoiTypeCombo').value;
	
	
	var requestUrl = '/maps/addNewPoi/' + lat + '/' + long + '/' + type + '/' + height + '/' + park + '/' + name + '/' + desc
	$.get(requestUrl, function(data){
		//alert("Color: "+color+" Route: "+routeNum);
	});
	sideBar.innerHTML += "<br>"+requestUrl;
	map.closePopup();
}

function deletePoi(id)
{
	var requestUrl = '/maps/deletePoi/' + id;
	$.get(requestUrl, function(data){
		//alert("Color: "+color+" Route: "+routeNum);
	});
	
	map.closePopup();
}
