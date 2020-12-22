class Event < ApplicationRecord

    belongs_to :member, foreign_key: "host_id" 
    has_many :buyers, through: :tickets, source: :member
    has_many :event_tags
    has_many :tags, through: :event_tags
    has_many :tickets    
    has_one :place, dependent: :destroy, through: :place_booking
    
end
