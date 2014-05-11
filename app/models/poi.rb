# == Schema Information
#
# Table name: pois
#
#  id          :integer          not null, primary key
#  lat         :float
#  long        :float
#  name        :string(255)
#  height      :integer
#  created_at  :datetime
#  updated_at  :datetime
#  description :string(255)
#  poi_type_id :integer
#  park_id     :integer
#

class Poi < ActiveRecord::Base
  attr_accessible :height, :lat, :long, :name, :description, :poi_type_id, :park_id
  belongs_to :park
  belongs_to :poi_type
  has_many :nodes
  validates :lat, numericality: {greater_than: -91, less_than: 91}
  validates :long, numericality: {greater_than: -181, less_than: 181}
  validates :height, numericality: true
  validates :poi_type_id, numericality: true
  validates :park_id, numericality: true
  
  def self.savePoi(id, type, lat, long, height, name)
		ActiveRecord::Base.transaction do
			thisPoi = Poi.find(id)
			thisPoi.poi_type_id = type unless type == 'undefined';
			thisPoi.lat = lat;
			thisPoi.long = long;
			thisPoi.height = height;
			thisPoi.name = name;
			thisPoi.save
		end
	end  
	
  def self.addNewPoi(park, type, lat, long, height, name, desc)
		ActiveRecord::Base.transaction do
			thisPoi = Poi.new()
			thisPoi.park_id = park;
			thisPoi.poi_type_id = type;
			thisPoi.lat = lat;
			thisPoi.long = long;
			thisPoi.height = height;
			thisPoi.name = name;
			thisPoi.description = desc;
			thisPoi.save
		end
	end  
  
end

