require 'csv'
ActiveRecord::Base.transaction do
  CSV.open('cat.rp.txt', 'r').each do |row|
    RoutePoint.create(routeName: row[3], lat: row[0], long: row[1], height: row[2])
  end
end
