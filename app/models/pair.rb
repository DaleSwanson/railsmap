# == Schema Information
#
# Table name: pairs
#
#  id         :integer          not null, primary key
#  n1         :integer
#  n2         :integer
#  route_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Pair < ActiveRecord::Base
  attr_accessible :n1, :n2, :route_id
  belongs_to :route
end
