class EventTag < ApplicationRecord

    #Association
    belongs_to :event
    belongs_to :tag

    #Validates
    validates :event_id,
        presence: true
    validates :tag_id,
        presence: true

end
