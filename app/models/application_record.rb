class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  #Define
    PLATINUM = 30
    GOLD = 20
    SILVER = 10
    BRONZE = 5
    STANDARD = 0

  #Method
  private def member_reputation(member)
        rank = 0
        begin
            member.events.each do |e|
                rank += e.reputations.count
            end
        rescue => error
        end
        return rank
    end

    private def member_rank(member_rep)
        v = 0
        if member_rep < BRONZE then
            v = 0
        elsif member_rep < SILVER then
            v = 1
        elsif member_rep < GOLD then
            v = 2
        elsif member_rep < PLATINUM then
            v = 3
        elsif member_rep >= PLATINUM then
            v = 4
        end
        return v
    end

end
