class CreatePairs < ActiveRecord::Migration
  def change
    create_table :pairs do |t|
      t.integer :n1
      t.integer :n2
      t.integer :route

      t.timestamps
    end
  end
end
