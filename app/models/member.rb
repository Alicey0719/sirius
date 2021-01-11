class Member < ApplicationRecord

    has_secure_password

    #Association
    has_many :events, foreign_key: "host_id", dependent: :destroy
    has_many :bookmarks, dependent: :destroy
    has_many :bookmarked_events, through: :bookmarks, source: :event
    has_many :tickets, dependent: :destroy
    has_many :reputations
    has_many :liked_events, through: :reputations, source: :event
    has_many :liked_event_hosts, through: :liked_events, source: :member
    
    #Validates
    attr_accessor :current_password
    validates :password,
        presence: {if: :current_password},
        length: {minimum: 4, maximum: 32, allow_blank: true},
        format: {with: /\A[A-Za-z0-9]*\z/, allow_blank: true}
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

    #Method
    def bookmark?(event)
        event && event.member != self && !bookmarks.exists?(event_id: event.id)
    end

end
