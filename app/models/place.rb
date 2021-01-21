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
        numericality:{less_than_or_equal_to: 99999, greater_than:0 }
    validates :rank,
        presence: true,
        numericality: { greater_than_or_equal_to:0 ,less_than_or_equal_to: 10}

end
