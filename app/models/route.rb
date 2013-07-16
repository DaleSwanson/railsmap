# == Schema Information
#
# Table name: routes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  color      :string(255)
#  range      :string(255)
#  number     :integer
#  maxHeight  :integer
#  minHeight  :integer
#  distance   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  gain       :integer
#  loss       :integer
#

class Route < ActiveRecord::Base
  attr_accessible :color, :distance, :gain, :loss, :maxHeight, :minHeight, :name, :number, :range
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :distance, numericality: true
  validates :gain, numericality: true
  validates :loss, numericality: true
  validates :maxHeight, numericality: true
  validates :minHeight, numericality: true
  validates :number, numericality: true
  
  
end
