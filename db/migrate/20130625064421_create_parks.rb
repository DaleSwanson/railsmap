class CreateParks < ActiveRecord::Migration
  def change
    create_table :parks do |t|
      t.string :name
      t.float :lat
      t.float :long
      t.string :customIcon

      t.timestamps
    end
  end
end
