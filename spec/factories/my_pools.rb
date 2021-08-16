FactoryBot.define do
  factory :my_pool do
    association :user, factory: :sequence_user
    expires_at { "2021-08-11 13:30:44" }
    title { "MyStringMyString" }
    description { "MyTextMyTextMyTextMyTextMyText" }
    factory :pool_with_questions do
      title { "Pool with questions" }
      description { "MyTextMyTextMyTextMyTextMyText" }
      questions { build_list :question, 2 }
    end
  end
end
