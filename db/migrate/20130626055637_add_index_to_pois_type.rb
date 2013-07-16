class AddIndexToPoisType < ActiveRecord::Migration
  def change
		add_index :pois, :poitype
  end
end
