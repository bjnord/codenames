FactoryBot.define do
  factory :game do
    sequence :name do |n|
      "Game #{n}"
    end
  end
end
