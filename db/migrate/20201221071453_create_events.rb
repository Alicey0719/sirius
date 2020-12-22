class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|

      t.references :host, null: false, foreign_key: { to_table: :members}
      t.string :name, null: false
      t.date :held_at, null: false
      t.integer :capacity, null: false
      t.integer :price, null: false
      t.text :detail, null: false
      
      t.timestamps
    end
  end
end
