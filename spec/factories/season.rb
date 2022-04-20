FactoryBot.define do
  factory :season do
    association :tv_show

    number{1}
  end
end
