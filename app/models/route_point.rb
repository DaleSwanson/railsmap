# == Schema Information
#
# Table name: route_points
#
#  id         :integer          not null, primary key
#  routeName  :string(255)
#  lat        :float
#  long       :float
#  height     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RoutePoint < ActiveRecord::Base
  attr_accessible :height, :lat, :long, :routeName
  validates :lat, numericality: {greater_than: -91, less_than: 91}
  validates :long, numericality: {greater_than: -181, less_than: 181}
  validates :height, numericality: true
  
end
