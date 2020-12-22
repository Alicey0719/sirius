tags=["カップル", "家族向け", "大人数", "少人数", "ライブ", "アイドル", "声優", "アニメ", "フェス"]

0.upto(8) do |idx|
  tag = Tag.create(
    name: tags[idx].to_s
  )
end