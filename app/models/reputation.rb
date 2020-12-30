class Reputation < ApplicationRecord

    #Association
    belongs_to :liked_member, class_name: "Member"
    belongs_to :like_member, class_name: "Member"

    #Validates
    validates :liked_member_id,
        presence: true
    validates :like_member_id,
        presence: true
    #like!=liked

end
