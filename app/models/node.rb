# == Schema Information
#
# Table name: nodes
#
#  id         :integer          not null, primary key
#  lat        :float
#  long       :float
#  poi_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Node < ActiveRecord::Base
  attr_accessible :lat, :long, :poi_id
  belongs_to :poi
end
