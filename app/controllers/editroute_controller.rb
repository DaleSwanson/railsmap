class EditrouteController < ApplicationController
	def showRoute
		@id = params[:id]
		@thisRoute = Route.find(@id)
		@points = RoutePoint.where(route_id: @id)
		
	end
	
	def breakRoute
		@id = params[:id]
		@lat = params[:lat]
		@long = params[:long]
		Route.breakRoute(@id, @lat, @long)
		head :ok
		
		
	end
	
end
