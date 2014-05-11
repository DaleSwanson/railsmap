class AddPoiTypeIdToPois < ActiveRecord::Migration
  def change
    add_column :pois, :poi_type_id, :integer
  end
end
