FactoryBot.define do
  factory :episode do
    name :hannibal
    season 4
    episode 5
    published_at Time.now

    trait :aired do
      air_date {Date.yesterday}
    end
  end
end
