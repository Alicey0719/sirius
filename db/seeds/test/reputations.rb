#Platina
30.times{ |t|
  Reputation.create(
    event: Event.find(5),
    member: Member.find(t+1)
    )
}
#Gold
20.times{ |t|
  Reputation.create(
    event: Event.find(4),
    member: Member.find(t+1)
    )
}
#Silver
10.times{ |t|
  Reputation.create(
    event: Event.find(3),
    member: Member.find(t+1)
    )
}
#bronze
5.times{ |t|
  Reputation.create(
    event: Event.find(2),
    member: Member.find(t+1)
    )
}
