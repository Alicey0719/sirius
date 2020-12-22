class CreatePlaceBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :place_bookings do |t|

      t.references :event, null: false
      t.references :place, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false

      t.timestamps
    end
  end
end
