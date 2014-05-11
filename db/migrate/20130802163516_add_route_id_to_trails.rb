class AddRouteIdToTrails < ActiveRecord::Migration
  def change
    add_column :trails, :route_id, :integer
  end
end
