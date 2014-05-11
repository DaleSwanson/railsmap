class CreateTrails < ActiveRecord::Migration
  def change
    create_table :trails do |t|
      t.string :number
      t.string :name
      t.string :park
      t.string :color
      t.float :mileage
      t.integer :hike_use
      t.integer :horse_use
      t.integer :bike_use
      t.integer :snowshoe_use
      t.integer :cross_country_use
      t.integer :snowmobile_use

      t.timestamps
    end
  end
end
