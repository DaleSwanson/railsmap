class AddParameterToPoiTypes < ActiveRecord::Migration
  def change
    add_column :poi_types, :parameter, :string
    add_column :poi_types, :size, :integer
  end
end
