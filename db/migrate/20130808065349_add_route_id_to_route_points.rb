class AddRouteIdToRoutePoints < ActiveRecord::Migration
  def change
		add_column :route_points, :route_id, :integer
  end
end
