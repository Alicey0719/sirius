class Bookmark < ApplicationRecord

    #Association
    belongs_to :event
    belongs_to :member

    #Validates
    validates :event_id,
        presence: true
    validates :member_id,
        presence: true

end
