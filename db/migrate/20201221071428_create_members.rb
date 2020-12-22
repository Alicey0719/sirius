class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|

      t.string :user_name,null: false
      t.string :full_name, null: false
      t.integer :gender, null: false, default: 1
      t.string :email, null: false
      t.date :birthday, null: false
      t.string :password, null: false

      t.timestamps
    end
  end
end
