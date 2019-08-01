FactoryBot.define do
  factory :episode do
    association :tv_show
    name{:hannibal}
    season{4}
    episode{5}
    published_at{Time.now}
    tmdb_details {}

    trait :aired do
      air_date{Date.yesterday}
    end
  end
end
