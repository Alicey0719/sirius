class Ticket < ApplicationRecord

    #Association
    belongs_to :event
    belongs_to :member

    #Validate
    validate do
        #在庫数とチケット数
        if event.tickets.count >= event.capacity
            errors.add(:base, :soldout)
        end

        #終了イベント
        if event.held_at < Date.today then
            errors.add(:base, :buy_time_over)
        end
    end
    
end
