class AddParkIdToPois < ActiveRecord::Migration
  def change
    add_column :pois, :park_id, :integer
  end
end
