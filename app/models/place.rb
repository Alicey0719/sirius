class Place < ApplicationRecord

    has_many :place_bookings, dependent: :destroy

end
