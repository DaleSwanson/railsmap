class CreateRoutePoints < ActiveRecord::Migration
  def change
    create_table :route_points do |t|
      t.string :routeName
      t.float :lat
      t.float :long
      t.integer :height

      t.timestamps
    end
  end
end
