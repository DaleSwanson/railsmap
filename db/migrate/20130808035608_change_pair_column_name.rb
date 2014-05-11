class ChangePairColumnName < ActiveRecord::Migration
  def change
    rename_column :pairs, :route, :route_id
  end
end
