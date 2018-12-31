Game.destroy_all
sessionid = rand(2**128).to_s(16)  # fast; doesn't need security
10.times do |n|
  g = Game.create!(sessionid: sessionid, name: "Old Game #{n+1}")
  g.update_attributes!(created_at: Time.now - (10-n).seconds)
end
g = Game.create!(sessionid: sessionid, name: "Today's Game")
Game::N_WORDS.times do |n|
  gw = GameWord.create(game: g, position: n, word: Faker::Lorem.unique.word)
end
