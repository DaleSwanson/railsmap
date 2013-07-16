class MapsController < ApplicationController
  def showMap
		@route = Route.all
		parkName = params[:id].downcase.gsub('%', '\%').gsub('_', '\_'); #sanitize
		parkName = "%;#{parkName};%"; #format for a sql wildcard search
		@park = Park.where('alternate LIKE ?', parkName).first #sql substring search
		
		@allRoutes = Route.where(range: @park.name)
		
		
		@listSummits = Poi.where(poitype: "List Summit", range: @park.name);
		@summits = Poi.where(poitype: "Summit", range: @park.name);
		@trailheads = Poi.where(poitype: "Trailhead", range: @park.name);
		@camps = Poi.where(poitype: "Camp", range: @park.name);
		@leantos = Poi.where(poitype: "Leanto", range: @park.name);
		@jcts = Poi.where(poitype: "Jct", range: @park.name);
  end
  
 
  
end
