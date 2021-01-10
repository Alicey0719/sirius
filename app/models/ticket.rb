class Ticket < ApplicationRecord

    #Association
    belongs_to :event
    belongs_to :member

    #Validate
    validate do
        #在庫数とチケット数
        if event.tickets.count >= event.capacity
            errors.add(:base, :invalid)
        end
    end
    
end
