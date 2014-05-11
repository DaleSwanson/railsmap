class CreateParkAliases < ActiveRecord::Migration
  def change
    create_table :park_aliases do |t|
      t.string :name
      t.integer :park_id

      t.timestamps
    end
  end
end
