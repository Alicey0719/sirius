1.upto(20) do |idx|
    m = Member.find(rand(1..10))
    e = Event.find(rand(1..5))
    Ticket.create(
        member_id: m.id,
        event_id: e.id
    )
end