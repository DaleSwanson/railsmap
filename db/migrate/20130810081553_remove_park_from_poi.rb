class RemoveParkFromPoi < ActiveRecord::Migration
  def up
    remove_column :pois, :park
    remove_column :pois, :poiType
  end

  def down
    add_column :pois, :poiType, :string
    add_column :pois, :park, :string
  end
end
