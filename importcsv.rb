require 'csv'
CSV.open('poi2.csv', 'r').each do |row|
	RoutePoint.create(routeName: row[0], lat: row[1], long: row[2], height: row[3])
end
