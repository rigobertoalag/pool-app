FactoryBot.define do
  factory :question do
    association :my_pool, factory: :my_pool
    description { "Cual es tu navegador prefereido?" }
  end
end
