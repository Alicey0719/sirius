class Event < ApplicationRecord

    #Association
    has_many :event_tags
    has_many :tags, through: :event_tags
    has_many :tickets, dependent: :destroy
    has_many :buyers, through: :tickets, source: :member
    has_many :reputations
    has_many :like_member, through: :reputations, source: :member
    has_one :place_booking, dependent: :destroy
    has_one :place, through: :place_booking    
    belongs_to :member, foreign_key: "host_id" 

    #Validates
    validates :host_id,
        presence: true
    validates :name,
        presence: true,
        length: {maximum: 20}
    validates :held_at,
        presence: true,
        date: {after: Proc.new{Time.now}},
        if: :new_or_held_at_changed
    validates :capacity,
        presence: true
    validates :price,
        presence: true
    validates :detail,
        presence: true,
        length: {maximum: 1500}

    #Method
    class << self
        def search(query)
            rel = order("held_at")
            if query.present?
                rel = rel.where("name LIKE ?", "%#{query}%")
            end
            return rel
        end
    end    

    def new_or_held_at_changed
        held_at.present? && (new_record? || will_save_change_to_held_at?)
    end

end
