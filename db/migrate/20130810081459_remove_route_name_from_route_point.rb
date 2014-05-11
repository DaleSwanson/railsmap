class RemoveRouteNameFromRoutePoint < ActiveRecord::Migration
  def up
    remove_column :route_points, :routeName
  end

  def down
    add_column :route_points, :routeName, :string
  end
end
