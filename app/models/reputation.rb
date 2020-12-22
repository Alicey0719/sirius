class Reputation < ApplicationRecord

    belongs_to :liked_member, class_name: "Member"
    belongs_to :like_member, class_name: "Member"

end
