# == Schema Information
#
# Table name: poi_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  icon       :string(255)
#  highlight  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parameter  :string(255)
#  size       :integer
#

class PoiType < ActiveRecord::Base
  attr_accessible :highlight, :icon, :name, :parameter, :size
  has_many :pois
end
