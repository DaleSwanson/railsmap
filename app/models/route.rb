# == Schema Information
#
# Table name: routes
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  color       :string(255)
#  number      :integer
#  maxHeight   :integer
#  minHeight   :integer
#  distance    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  gain        :integer
#  loss        :integer
#  description :string(255)
#  trail_id    :integer
#  park_id     :integer
#

class Route < ActiveRecord::Base
  attr_accessible :color, :distance, :gain, :loss, :maxHeight, :minHeight, :name, :number, :park, :description, :trail_id, :park_id 
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :distance, numericality: true
  validates :gain, numericality: true
  validates :loss, numericality: true
  validates :maxHeight, numericality: true
  validates :minHeight, numericality: true
  validates :number, numericality: true
  belongs_to :trail
  belongs_to :park
  has_many :route_points, dependent: :destroy
  has_many :pairs, dependent: :destroy
  
	def self.updateRoute(id, color, number, distance, description)
		ActiveRecord::Base.transaction do
			route = Route.find(id)
			route.color = color unless color == 'undefined';
			route.number = number;
			route.distance = distance;
			route.description = description;
			route.save
		end
	end  
  
  
  
	def self.updateColor(id, color)
		ActiveRecord::Base.transaction do
			route = Route.find(id)
			route.color = color;
			route.save
		end
	end
  
	def self.updateRouteNum(id, num)
		ActiveRecord::Base.transaction do
			route = Route.find(id)
			route.number = num;
			route.save
		end
	end
  
  def self.updateDistance(id, dis)
		ActiveRecord::Base.transaction do
			route = Route.find(id)
			route.distance = dis;
			route.save
		end
	end
	
	def self.updateDescription(id, description)
		ActiveRecord::Base.transaction do
			route = Route.find(id)
			route.description = description;
			route.save
		end
	end  
  
  
	def self.breakRoute(id, lat, long)
		
		thisRoute = Route.find(id)
		newRouteName = thisRoute.name+'_'+(0...3).map{ ('a'..'z').to_a[rand(26)] }.join
		
		newRoute = Route.new(name: newRouteName, color: thisRoute.color, number: thisRoute.number, description: thisRoute.description, trail_id: thisRoute.trail_id, park_id: thisRoute.park_id, 
		maxHeight: 0, minHeight: 0, distance: 0, gain: 0, loss: 0  )
		newRoute.save
		
		thisPoint = RoutePoint.where(lat: lat, long: long).first
		
		RoutePoint.new(route_id: newRoute.id, lat: thisPoint.lat, long: thisPoint.long, height: thisPoint.height).save;
		
		newPoints = RoutePoint.where("route_id = ? AND id > ?", id, thisPoint.id)
		
		ActiveRecord::Base.transaction do
			newPoints.each do |point|
				RoutePoint.new(route_id: newRoute.id, lat: point.lat, long: point.long, height: point.height).save;
				point.destroy;
			end
		end
	end  
  
  def self.randomRoute(park, lat, long, num)
		ActiveRecord::Base.transaction do
			num ||= 30; #default route length
			bigAdj = 0.001;
			smallAdj = 0.0005;
			lat = lat.to_f;
			long = long.to_f;
			
			routeName = "Test_"+(0...3).map{ ('a'..'z').to_a[rand(26)] }.join
			
			newRoute = Route.new(name: routeName, color:"#0f0", park_id: park, number:0, maxHeight:0, minHeight:0, distance:0, gain:0, loss:0)
			newRoute.save;
			RoutePoint.new(route_id: newRoute.id, lat: lat, long: long, height: 0).save
			
			latTrend = Random.new.rand(-bigAdj..bigAdj);
			longTrend = Random.new.rand(-bigAdj..bigAdj);
			(1..num).each do |i|
				latAdj = latTrend + Random.new.rand(-smallAdj..smallAdj);
				longAdj = longTrend + Random.new.rand(-smallAdj..smallAdj);
				lat += latAdj;
				long += longAdj;
				RoutePoint.new(route_id: newRoute.id, lat: lat, long: long, height: 1000).save
				
				
			end
		end
  end
  
  
end
