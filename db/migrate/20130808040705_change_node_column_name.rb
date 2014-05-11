class ChangeNodeColumnName < ActiveRecord::Migration
  def change
    rename_column :nodes, :poi, :poi_id
  end
end
