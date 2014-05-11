class AddParkIdToTrails < ActiveRecord::Migration
  def change
    add_column :trails, :park_id, :integer
  end
end
