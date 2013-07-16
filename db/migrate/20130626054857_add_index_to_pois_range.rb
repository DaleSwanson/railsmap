class AddIndexToPoisRange < ActiveRecord::Migration
  def change
		add_index :pois, :range
  end
end
