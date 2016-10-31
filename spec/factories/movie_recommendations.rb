FactoryGirl.define do
  factory :movie_recommendation do
    sequence :imdb_id do |n|
      "tt0386#{n}"
    end
    sequence :tmdb_id do |n|
      "tmdb_#{n}"
    end

    sequence :title do |n|
      "#{Faker::Name.name}#{n}"
    end

    year 1999
  end
end
