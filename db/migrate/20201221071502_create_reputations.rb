class CreateReputations < ActiveRecord::Migration[5.2]
  def change
    create_table :reputations do |t|

      t.references :member, null: false
      t.references :event, null: false

      t.timestamps
    end
  end
end
