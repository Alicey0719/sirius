class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|

      t.references :event ,null: false
      t.references :member ,null: false

      t.timestamps
    end
  end
end
