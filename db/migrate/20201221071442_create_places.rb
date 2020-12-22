class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|

      t.string :name, null: false 
      t.string :address, null: false 
      t.integer :capacity, null: false 
      t.integer :rank, null: false

      t.timestamps
    end
  end
end
