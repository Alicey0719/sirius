class PlaceBooking < ApplicationRecord

    #Association
    belongs_to :place
    belongs_to :event

    #Validate
    validates :event,
        presence: true,
        unless: -> {validation_context == :check}
    validates :place,
        presence: true
    validates :start_time,
        presence: true
    validates :end_time,
        presence: true
    validate :start_end_check
    validate :current_before
    validate :overlap_check
    validate :rank_check

    #Method
    def start_end_check
        #会場利用時間が矛盾しないか
        errors.add(:base, :placetime_startend) unless self.start_time < self.end_time
    end
    
    def current_before
        #会場利用時間が現在時刻より後か
        errors.add(:base, :placetime_current_before) unless Time.now < self.start_time
    end

    def overlap_check
        if PlaceBooking.where('end_time > ? and ? > start_time', self.start_time, self.end_time).present? then
            errors.add(:base, :overlap_check)
        end
    end

    def rank_check
        mrank = member_rank(member_reputation(self.event.member))
        unless self.place.rank <= mrank then
            errors.add(:base, :rank_check)
        end
    end

end
