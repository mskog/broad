FactoryBot.define do
  factory :movie_release_date do
    release_date{Date.tomorrow}
    release_type{"4K UHD"}
  end
end
