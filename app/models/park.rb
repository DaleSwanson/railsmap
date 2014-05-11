# == Schema Information
#
# Table name: parks
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  lat         :float
#  long        :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :string(255)
#  zoom        :integer
#

class Park < ActiveRecord::Base
  attr_accessible :alternate, :customIcon, :lat, :long, :name, :description, :zoom
  has_many :pois
  has_many :routes
  has_many :aliases
  
  VALID_ALT = /^\;.+\;$/ #semicolons
  validates :alternate, format: { with: VALID_ALT, message: "must end and begin with ;" }
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :lat, numericality: {greater_than: -91, less_than: 91}
  validates :long, numericality: {greater_than: -181, less_than: 181}
  validates :zoom, numericality: {greater_than: 0, less_than: 20}
  
end
