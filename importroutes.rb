require 'csv'
ActiveRecord::Base.transaction do
  CSV.open('cat.r.txt', 'r').each do |row|
    Route.create(name: row[0], description: row[2], color: row[3], number: row[4], maxHeight: row[5], minHeight: row[6], distance: row[7], gain: row[8], loss: row[9], trail_id: 0, park_id: 2)
  end
end

