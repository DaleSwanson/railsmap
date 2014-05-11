require 'csv'
CSV.open('trailstable.csv', 'r').each do |row|
	Trail.create(number: row[0], name: row[1], park: row[2], color: row[3], mileage: row[4], hike_use: row[5], horse_use: row[6], bike_use: row[7], snowshoe_use: row[8], cross_country_use: row[9], snowmobile_use: row[10])
end

