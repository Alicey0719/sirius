0.upto(9) do |idx|
  id = rand(1..10)
  while id == (idx+1)
    id = rand(1..10)
  end
  Reputation.create(
    liked_member_id: idx+1,
    like_member_id: id
  )
end