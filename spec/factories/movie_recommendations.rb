FactoryGirl.define do
  factory :movie_recommendation do
    sequence :imdb_id do |n|
      "tt0386#{n}"
    end
    title Faker::Name.name
    year 1999
  end
end
