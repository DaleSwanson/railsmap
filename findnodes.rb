MIN_POI_DISTANCE = 25; #feet, if we're under this we will return it early
MIN_NODE_DISTANCE = 100; #feet

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


def findPoi(lat, long)
	
	closestDistance = 10000;
	closestPoi=0;
	#given a lat, long pair find nearest poi
	pois = Poi.all
	pois.each do |poi|
		distance = haversine(poi.lat, poi.long, lat, long)
		if distance < MIN_POI_DISTANCE
			#this is our node
			return poi.id
		elsif distance < closestDistance
			closestDistance = distance
			closestPoi = poi.id
		end
	end
	#whatever poi we have here is the closest
	
	return closestPoi
end


def findNode(lat, long)
	
	#given a lat, long pair find nearest node, or create one
	nodes = Node.all
	nodes.each do |node|
		distance = haversine(node.lat, node.long, lat, long)
		if distance < MIN_NODE_DISTANCE
			#this is our node
			return node.id
		end
	end
	#if we make it here that means we haven't found a node, so we must make one
	
	#findPoi(lat, long)
	
	newNode = Node.new(lat: lat, long: long, poi_id: findPoi(lat, long))
	newNode.save
	
	
	return newNode.id
end



routes = Route.where(park_id: 1) #test routes
routes.each do |thisRoute|
	startPoint = RoutePoint.where(route_id: thisRoute.id).first
	endPoint = RoutePoint.where(route_id: thisRoute.id).last
	
	Pair.new(n1: findNode(startPoint.lat, startPoint.long), n2: findNode(endPoint.lat, endPoint.long), route_id: thisRoute.id).save;
	
	
	print "\nRoute: #{thisRoute.name}";
	
end

