class Member < ApplicationRecord

    has_secure_password

    #Association
    has_many :events, foreign_key: "host_id"
    has_many :bookmarks
    has_many :bookmarked_events, through: :bookmarks, source: :event
    has_many :tickets
    has_many :liked_members,  class_name: "Reputation", foreign_key: "liked_member_id"
    has_many :like_members,  class_name: "Reputation", foreign_key: "like_member_id"

    #Validates
    validates :password,
        presence: true,
        length: {minimum: 4, maximum: 32},
        format: {with: /\A[A-Za-z0-9]*\z/}
    validates :user_name,
        presence: true,
        format: {with: /\A[A-Za-z][A-Za-z0-9]*\z/, allow_blank: true},
        length: {minimum: 2, maximum: 20, allow_blank: true},
        uniqueness: {case_sensitive: false}
    validates :full_name,
        presence: true,
        length: {maximum: 20}
    validates :gender,
        presence: true, 
        format: {with: /\A[1-3]\z/, allow_blank: true},
        length: {minimum: 1, maximum: 1, allow_blank: true}
    validates :email,
        presence: true, 
        email: {allow_blank: true}
    validates :birthday,
        date: {before: Proc.new{(Date.today)}}  


    #memo
    # attr_accessor :current_password
    # validates :password, presence:{if: :current_password}


end
