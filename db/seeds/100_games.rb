Game.destroy_all
10.times do |n|
  g = Game.create!(name: "Old Game #{n+1}")
  g.update_attributes!(created_at: Time.now - (10-n).seconds)
end
g = Game.create!(name: "Today's Game")
Game::N_WORDS.times do |n|
  gw = GameWord.create(game: g, position: n, word: Faker::Lorem.unique.word)
end
