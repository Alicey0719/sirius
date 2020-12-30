%w(John Mike Sophy).each do |name|
  member = Member.find_by(user_name: name)
  event = Event.find_by(id: rand(1..5))
  member.bookmarked_events << event
end