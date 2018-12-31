FactoryBot.define do
  factory :game_word do
    game
    sequence :position do |n|
      n % Game::N_WORDS
    end
    word { Faker::Lorem.unique.word }
  end
end
