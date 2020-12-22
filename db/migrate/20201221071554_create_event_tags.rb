class CreateEventTags < ActiveRecord::Migration[5.2]
  def change
    create_table :event_tags do |t|

      t.references :event, null: false
      t.references :tag, null: false

      t.timestamps
    end
  end
end
