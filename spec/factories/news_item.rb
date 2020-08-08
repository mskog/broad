FactoryBot.define do
  factory :news_item do
    title{Faker::Name.unique.name}
    url{Faker::Internet.unique.url}
    score{rand(100_000)}
  end
end
