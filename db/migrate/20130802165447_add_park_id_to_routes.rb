class AddParkIdToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :park_id, :integer
  end
end
