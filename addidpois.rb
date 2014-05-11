pois = Poi.where(poiType: "List Summit", park_id: 2)
ActiveRecord::Base.transaction do
  pois.each do |poi|
    poi.poi_type_id = 9
    poi.save
  end
end

