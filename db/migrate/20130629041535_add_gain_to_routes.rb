class AddGainToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :gain, :integer
    add_column :routes, :loss, :integer
  end
end
