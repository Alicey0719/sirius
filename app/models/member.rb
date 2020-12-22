class Member < ApplicationRecord

    has_many :events, foreign_key: "host_id"
    has_many :bookmarks
    has_many :bookmarked_events, through: :bookmarks, source: :event
    has_many :tickets
    has_many :liked_members,  class_name: "Reputation", foreign_key: "liked_member_id"
    has_many :like_members,  class_name: "Reputation", foreign_key: "like_member_id"

end
