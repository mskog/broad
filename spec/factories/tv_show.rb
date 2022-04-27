FactoryBot.define do
  factory :tv_show do
    name{:hannibal}
    tvdb_id{rand(100_000)}
  end
end
