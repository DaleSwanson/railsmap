class RemoveParkFromRoute < ActiveRecord::Migration
  def up
    remove_column :routes, :park
  end

  def down
    add_column :routes, :park, :string
  end
end
