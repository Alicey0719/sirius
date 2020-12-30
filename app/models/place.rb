class Place < ApplicationRecord

    #Association
    has_many :place_bookings, dependent: :destroy

    #Validates
    validates :name,
        presence: true,
        length: {maximum: 20}
    validates :address,
        presence: true,
        length: { maximum: 50}
    validates :capacity,
        presence: true,
        length: { maximum: 99999}
    validates :rank,
        presence: true,
        length: { minimum:0 ,maximum: 100}

end
