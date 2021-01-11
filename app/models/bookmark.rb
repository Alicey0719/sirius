class Bookmark < ApplicationRecord

    #Association
    belongs_to :event
    belongs_to :member

    #Validates
    validates :event,
        presence: true
    validates :member,
        presence: true
    validate :user_check
    
    #Method
    private def user_check
        if self.member == self.event.member then
            errors.add(:base, :reputation_user_check)
        end
    end

end
