# == Schema Information
#
# Table name: pois
#
#  id         :integer          primary key
#  lat        :float
#  long       :float
#  poitype    :string(255)
#  name       :string(255)
#  elevation  :integer
#  range      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Poi < ActiveRecord::Base
  attr_accessible :elevation, :lat, :long, :name, :poitype, :range
  belongs_to :park
  validates :lat, numericality: {greater_than: -91, less_than: 91}
  validates :long, numericality: {greater_than: -181, less_than: 181}
  validates :elevation, numericality: true
end
