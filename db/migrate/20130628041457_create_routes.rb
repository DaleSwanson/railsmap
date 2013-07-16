class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :name
      t.string :color
      t.string :range
      t.integer :number
      t.integer :maxHeight
      t.integer :minHeight
      t.integer :distance

      t.timestamps
    end
  end
end
