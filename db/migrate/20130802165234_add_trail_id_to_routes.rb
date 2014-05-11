class AddTrailIdToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :trail_id, :integer
  end
end
