(13195..13253).each do |id|
	test = RoutePoint.find(id)
	test.destroy
end
