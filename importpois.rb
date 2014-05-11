require 'csv'
ActiveRecord::Base.transaction do
  CSV.open('testpois.csv', 'r').each do |row|
    Poi.create(name: row[0], lat: row[1], long: row[2], height: row[3], poiType: row[4], park: row[5], description: row[6])
  end
end
