require 'csv'
CSV.open('heights.csv', 'r').each do |row|
	point = RoutePoint.find(row[0]);
	point.height = row[1];
	point.save;
end
