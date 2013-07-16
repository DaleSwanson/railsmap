require 'csv'
CSV.open('heights.csv', 'r').each do |row|
	poi = Poi.find(row[0]);
	poi.elevation = row[1];
	poi.save;
end
