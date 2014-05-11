class NewColumnNames < ActiveRecord::Migration
  def change
    rename_column :pois, :poitype, :poiType
    rename_column :pois, :range, :park
    rename_column :pois, :elevation, :height
    rename_column :routes, :range, :park
  end
end
