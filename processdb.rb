print "\nStart\n";

def haversine(lat1, long1, lat2, long2)
	dtor = Math::PI/180
	r = 20925524.9 #radius of earth in feet
	 
	rlat1 = lat1 * dtor
	rlong1 = long1 * dtor
	rlat2 = lat2 * dtor
	rlong2 = long2 * dtor
	 
	dlon = rlong1 - rlong2
	dlat = rlat1 - rlat2
	 
	a = (Math::sin(dlat/2) ** 2) + Math::cos(rlat1) * Math::cos(rlat2) * (Math::sin(dlon/2) ** 2)
	c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
	d = r * c
	 
	return d #same units as r is defined in
end


allRoutes = Route.where(park_id: 4)
allRoutes.each do |route| #go through each route
	max = 0 #max height along route
	min = 10000 #min height along route
	gain = 0 #all elevation gains along route totalled
	loss = 0 #all elevation losses
	lastheight=0 #previous height
	lastlat=3.2 #previous lat
	lastlong=4.1 #previous long
	distance = 0 #total distance
	
	allRoutePoints = RoutePoint.where(routeName: route.name) #get all the points on this route
	lastheight=allRoutePoints.first.height #set up these so the results will be 0 for the first point
	lastlat=allRoutePoints.first.lat
	lastlong=allRoutePoints.first.long
	allRoutePoints.each do |point| #go through each point along this route
		max = point.height if point.height > max #new max height
		min = point.height if point.height < min #new min height
		if lastheight < point.height #add gain
			gain += (lastheight - point.height).abs
		elsif lastheight > point.height #add loss
			loss += (lastheight - point.height).abs
		end
		distance += haversine(lastlat, lastlong, point.lat, point.long) #total distance of route
		
		lastheight = point.height
		lastlat = point.lat
		lastlong = point.long
	end
	#all points gone through, data should be good
	print "\nID: #{route.id} Max: #{max} Min: #{min} Gain: #{gain} Loss: #{loss} Dis: #{distance}";
	route.maxHeight = max
	route.minHeight = min
	route.gain = gain
	route.loss = loss
	route.distance = distance
	route.save
end



