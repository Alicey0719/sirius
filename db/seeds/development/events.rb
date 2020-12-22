names1 = ["", "みんなで", "集まれ！", "盛り上がれ！"]
names2 = ["みんなの音楽会", "スマブラ大会", "ROCK◎FESTIVAL", "ジ◯リ音楽祭","スプラトゥーン全国予選"]
0.upto(4) do |idx|
  member = Member.find_by(id: rand(1..10))
  Event.create(
    host_id: member.id,
    name: "#{names1[idx % 4]} #{names2[idx % 5]}",
    held_at: "2021-#{rand(1..12)}-01",
    capacity: 0,
    price: rand(1000..3000),
    detail: "--イベント詳細を記述--"
  )
end