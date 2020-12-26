FactoryBot.define do
  factory :deck_word do
    word { Faker::Lorem.unique.word }
  end
end
