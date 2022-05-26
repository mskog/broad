FactoryBot.define do
  factory :movie do
    imdb_id{"tt0386064"}
    title{"The Matrix"}
    release_date{6.months.ago}
  end
end
