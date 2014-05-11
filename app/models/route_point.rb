# == Schema Information
#
# Table name: route_points
#
#  id         :integer          not null, primary key
#  lat        :float
#  long       :float
#  height     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  route_id   :integer
#

class RoutePoint < ActiveRecord::Base
  attr_accessible :height, :lat, :long, :routeName, :route_id
  validates :lat, numericality: {greater_than: -91, less_than: 91}
  validates :long, numericality: {greater_than: -181, less_than: 181}
  validates :height, numericality: true
  belongs_to :route
end
