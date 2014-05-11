ActiveRecord::Base.transaction do
	Pois = Poi.where("id > ?", 422)
	Pois.each do |poi|
		poi.destroy
	end
end

