class CreatePois < ActiveRecord::Migration
  def change
    create_table :pois do |t|
      t.float :lat
      t.float :long
      t.string :poitype
      t.string :name
      t.integer :elevation
      t.string :range

      t.timestamps
    end
  end
end
