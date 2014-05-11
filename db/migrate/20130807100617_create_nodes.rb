class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.float :lat
      t.float :long
      t.integer :poi

      t.timestamps
    end
  end
end
