class CreateReputations < ActiveRecord::Migration[5.2]
  def change
    create_table :reputations do |t|

      t.references :liked_member, null: false, foreign_key: { to_table: :members}
      t.references :like_member, null: false, foreign_key: { to_table: :members}

      t.timestamps
    end
  end
end
