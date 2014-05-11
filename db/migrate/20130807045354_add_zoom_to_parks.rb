class AddZoomToParks < ActiveRecord::Migration
  def change
		add_column :parks, :zoom, :integer
  end
end
