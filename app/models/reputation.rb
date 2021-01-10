class Reputation < ApplicationRecord

    #Association
    belongs_to :event
    belongs_to :member   
end
