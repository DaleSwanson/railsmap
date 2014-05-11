module RoutesHelper
	FEET_IN_MILE = 5280
  
  def feetToMiles(feet)
		
		miles = "%.4f" % (feet.to_f / FEET_IN_MILE.to_f)
		return miles
	end
end
