class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|

      t.string :password, null: false
      t.string :user_name, null: false 
      t.string :full_name, null: false

      t.timestamps
    end
  end
end
