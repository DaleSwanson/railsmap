# == Schema Information
#
# Table name: trails
#
#  id                :integer          not null, primary key
#  number            :string(255)
#  name              :string(255)
#  park              :string(255)
#  color             :string(255)
#  mileage           :float
#  hike_use          :integer
#  horse_use         :integer
#  bike_use          :integer
#  snowshoe_use      :integer
#  cross_country_use :integer
#  snowmobile_use    :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  route_id          :integer
#  park_id           :integer
#

class Trail < ActiveRecord::Base
  attr_accessible :bike_use, :color, :cross_country_use, :hike_use, :horse_use, :mileage, :name, :number, :park, :snowmobile_use, :snowshoe_use
  has_many :routes
end
