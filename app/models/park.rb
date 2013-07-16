# == Schema Information
#
# Table name: parks
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  lat        :float
#  long       :float
#  customIcon :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  alternate  :string(255)
#

class Park < ActiveRecord::Base
  attr_accessible :alternate, :customIcon, :lat, :long, :name
  has_many :pois
  
  VALID_ALT = /^\;.+\;$/ #semicolons
  validates :alternate, format: { with: VALID_ALT, message: "must end and begin with ;" }
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :lat, numericality: {greater_than: -91, less_than: 91}
  validates :long, numericality: {greater_than: -181, less_than: 181}
  
end
