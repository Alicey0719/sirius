addresses = ["東京", "神奈川", "千葉", "埼玉","群馬","茨城"]
names = ["会議室A", "会議室B", "会議室C","アリーナA","アリーナB","アリーナC","大ホール","中ホール","小ホール","蒼翼の間"]
0.upto(9) do |idx|
  Place.create(
    name: names[idx],
    address: addresses[idx % 6],
    rank: idx % 5,
    capacity: 10*(idx%5+1)*1000
  )
end
