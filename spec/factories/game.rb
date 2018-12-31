FactoryBot.define do
  factory :game do
    sessionid { rand(2**128).to_s(16) }  # fast; doesn't need security
    sequence :name do |n|
      "Game #{n}"
    end
  end
end
