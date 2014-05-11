class MapsController < ApplicationController
  def showMap
		@data = params[:data]
		
		@startZoom = params[:z]
		@startLat  = params[:lat]
		@startLong = params[:long]
		
		@trailOn     = params[:tr]
		@usgsOn      = params[:us]
		@scannedOn   = params[:sc]
		@baseLayer   = params[:base]
		@colorize    = params[:colorize].to_i
		@nodesOn    = params[:nodes].to_i
		

		#@route = Route.all(include: :park)
		
		altName = params[:id].downcase.gsub('%', '\%').gsub('_', '\_'); #sanitize
		parkId = ParkAlias.where(name: altName).first.park_id
		@park = Park.find(parkId)
		
		@allRoutes = Route.includes(:park).where(park_id: @park.id)
		
		#defaults:
		@startLat  ||= @park.lat
		@startLong ||= @park.long
		@startZoom ||= @park.zoom;
		
		if @trailOn == '1' then	@trailOn = true else @trailOn = false end
		@usgsOn      ||= 0
		@scannedOn   ||= 0
		@baseLayer   ||= "None"
		@colorize    ||= 0
		@nodesOn     ||= 0
		
		
		@pois = Poi.includes(:poi_type).where(park_id: @park.id);
		#@poi_types = @pois.uniq.pluck(:poi_type_id)
		@poi_types = PoiType.find(@pois.uniq.pluck(:poi_type_id))
		
		@layerOn = [];
		@poi_types.each do |type|
			if params[type.parameter.to_sym] == '0'
				@layerOn[type.id] = false;
			elsif params[type.parameter.to_sym] == '1'
				@layerOn[type.id] = true;
			else
				@layerOn[type.id] = true; #default on
			end
		end
		
		@nodes = Node.includes(:poi).all;
		@pairs = Pair.includes(:route).all;
  end
  
 	def updateRoute
		@id = params[:id]
		@color = params[:color]
		@routeNum = params[:num]
		@distance = params[:dis]
		@description = params[:description]
		Route.updateRoute(@id, @color, @routeNum, @distance, @description)
		head :ok
	end		  
  
 	def updateColor
		@id = params[:id]
		@color = params[:color]
		Route.updateColor(@id, @color)
		head :ok
	end		
	
 	def updateRouteNum
		@id = params[:id]
		@num = params[:num]
		Route.updateRouteNum(@id, @num)
		head :ok
	end	
	
 	def updateDescription
		@id = params[:id]
		@description = params[:description]
		Route.updateDescription(@id, @description)
		head :ok
	end		
	
 	def updateDistance
		@id = params[:id]
		@distance = params[:distance]
		Route.updateDistance(@id, @distance)
		head :ok
	end		
	
	def savePoi
		@id = params[:id]
		@type = params[:type]
		@lat = params[:lat]
		@long = params[:long]
		@height = params[:height]
		@name = params[:name]
		Poi.savePoi(@id, @type, @lat, @long, @height, @name)
		head :ok		
	end
	
	def addNewPoi
		@park = params[:park]
		@type = params[:type]
		@lat = params[:lat]
		@long = params[:long]
		@height = params[:height]
		@name = params[:name]
		@desc = params[:desc]
		@desc ||= '';
		@height ||= 0;
		
		Poi.addNewPoi(@park, @type, @lat, @long, @height, @name, @desc)
		head :ok		
		
	end
	
	def deletePoi
		@id = params[:id]
		Poi.find(@id).destroy;
		head :ok		
	end	
	
	def randomRoute
		@id = params[:id]
		@lat = params[:lat]
		@long = params[:long]
		@num = params[:num]
		Route.randomRoute(@id, @lat, @long, @num)
		head :ok		
	end
end
