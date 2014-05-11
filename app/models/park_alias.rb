# == Schema Information
#
# Table name: park_aliases
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  park_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ParkAlias < ActiveRecord::Base
  attr_accessible :name, :park_id
  belongs_to :park
end
