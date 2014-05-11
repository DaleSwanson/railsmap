ActiveRecord::Base.transaction do
  routes = Route.all
  routes.each do |route|
    routepoints = RoutePoint.where(RouteName: route.name)
    routepoints.each do |point|
      point.route_id = route.id
      point.save
    end
  end
end



