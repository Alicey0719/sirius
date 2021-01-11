class Tag < ApplicationRecord

    #Association
    has_many :event_tags
    has_many :events, through: :event_tags

    #Validates
    validates :name,
        presence: true,
        length: {minimum: 2, maximum: 15},
        uniqueness: true
    
end
