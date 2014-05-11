ActiveRecord::Base.transaction do
  points = RoutePoint.all
  points.each do |point|
    unless Route.exists?(name: point.routeName)
      #print "\n#{point.routeName}";
      point.destroy;
    end
  end
end

