Game.destroy_all
10.times do |n|
  g = Game.create!(name: "Old Game #{n+1}")
  g.update_attributes!(created_at: Time.now - (10-n).seconds)
end
Game.create!(name: "Today's Game")
