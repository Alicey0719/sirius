PlaceBooking.create(
        event_id: 1,
        place_id: 1,
        start_time: "2021-04-10 08:00:00 +0900",
        end_time: "2021-04-10 21:00:00 +0900"
)
PlaceBooking.create(
        event_id: 2,
        place_id: 2,
        start_time: "2021-04-15 08:00:00 +0900",
        end_time: "2021-04-15 21:00:00 +0900"
)
PlaceBooking.create(
        event_id: 3,
        place_id: 3,
        start_time: "2021-05-20 09:00:00 +0900",
        end_time: "2021-05-20 20:00:00 +0900"
)
PlaceBooking.create(
        event_id: 4,
        place_id: 4,
        start_time: "2021-08-10 00:00:00 +0900",
        end_time: "2021-08-14 23:00:00 +0900"
)
PlaceBooking.create(
        event_id: 5,
        place_id: 5,
        start_time: "2021-09-20 05:00:00 +0900",
        end_time: "2021-09-20 21:00:00 +0900"
)
1.upto(5) do |idx|
        p = Place.find(idx)
        e = Event.find(idx)
        e.capacity = p.capacity
        e.save
end