class Event < ApplicationRecord

    #Association
    has_many :event_tags
    has_many :tags, through: :event_tags
    has_many :tickets
    has_many :buyers, through: :tickets, source: :member    
    has_one :place, dependent: :destroy, through: :place_booking
    belongs_to :member, foreign_key: "host_id" 

    #Validates
    validates :host_id,
        presence: true
    validates :name,
        presence: true,
        length: {maximum: 20}
    validates :held_at,
        presence: true,
        date: {after: Proc.new{Time.now}}
    validates :capacity,
        presence: true
    validates :price,
        presence: true
    validates :detail,
        presence: true,
        length: {maximum: 1500}

end
