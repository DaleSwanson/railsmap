class AddAltToParks < ActiveRecord::Migration
  def change
    add_column :parks, :alternate, :string
  end
end
