FactoryBot.define do
  factory :movie_release_date do
    release_date{Date.today}
    release_type{"DVD"}
  end
end
