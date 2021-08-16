FactoryBot.define do
  factory :token do
    expires_at { "2021-08-06 17:30:03" }
    association :user, factory: :user
  end
end
