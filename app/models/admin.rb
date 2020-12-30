class Admin < ApplicationRecord

    has_secure_password

    #Validates
    validates :user_name,
        presence: true,
        format: {with: /\A[A-Za-z][A-Za-z0-9]*\z/, allow_blank: true},
        length: {minimum: 2, maximum: 20, allow_blank: true},
        uniqueness: {case_sensitive: false}
    validates :full_name,
        presence: true,
        length: {maximum: 20}
    validates :password,
        presence: true,
        length: {minimum: 4, maximum: 32},
        format: {with: /\A[A-Za-z0-9]*\z/}


end
