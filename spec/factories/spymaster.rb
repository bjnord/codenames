FactoryBot.define do
  factory :spymaster do
    game
    sessionid { rand(2**128).to_s(16) }  # fast; doesn't need security
  end
end
