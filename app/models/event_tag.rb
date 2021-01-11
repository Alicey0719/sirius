class EventTag < ApplicationRecord

    #Association
    belongs_to :event
    belongs_to :tag

    #Validates
    validates :event,
        presence: true
    validates :tag,
        presence: true,
        uniqueness: { scope: :event }

end
