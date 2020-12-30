events = Event.where(id: 1..5)
events.each do |event|
  tag = Tag.find_by(id: rand(1..9))
  event.tags << tag
end