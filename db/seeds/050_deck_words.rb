DeckWord.destroy_all
75.times do |n|
  DeckWord.create(word: Faker::Lorem.unique.word)
end
