class RemoveCustomIconFromPark < ActiveRecord::Migration
  def up
    remove_column :parks, :customIcon
    remove_column :parks, :alternate
  end

  def down
    add_column :parks, :alternate, :string
    add_column :parks, :customIcon, :string
  end
end
