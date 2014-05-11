//general purpose utilities

function RoundTo(num, digits)
{//rounds num to #digits past decimal
	var offset = Math.pow(10,digits);
	var num = Math.round(offset*num)/offset
	return num;	
}

function FeetToMiles(feet)
{//rounds num to #digits past decimal
	var miles = feet / 5280;
	return RoundTo(miles, 2);
}

function haversine(lat1, long1, lat2, long2)
{//finds distance between two lat long pairs
	Number.prototype.toRad = function() {
		 return this * Math.PI / 180;
	}
	
	var R = 20908000; // radius of earth in feet
	var x1 = lat2-lat1;
	var dLat = x1.toRad();  
	var x2 = long2-long1;
	var dLon = x2.toRad();  
	var a = Math.sin(dLat/2) * Math.sin(dLat/2) + 
									Math.cos(lat1.toRad()) * Math.cos(lat2.toRad()) * 
									Math.sin(dLon/2) * Math.sin(dLon/2);  
	var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
	var dis = R * c; 

	return dis;	//same units as R
}

function removeFromArray(array, value)
{//removes the given value from the array
	var index = array.indexOf(value);
	array.splice(index, 1);
}
