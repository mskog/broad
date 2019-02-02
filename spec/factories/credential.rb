FactoryBot.define do
  factory :credential do
    name { 'trakt' }
    data {Hash("access_token" => 'access', "refresh_token" => 'refresh')}
  end
end
