FactoryBot.define do
    factory :user do
      email { "rigo2@mail.com" }
      name {"Rigo"}
      provider {"twitter"}
      uid {"f492d5d408d365541fa67880f810b8c6"}
      factory :dummy_user do
        email { "peep2@mail.com" }
        name {"Pepe"}
        provider {"facebook"}
        uid {"f492d5d408d365541fa67880f810b8c6"}
      end
      factory :sequence_user do 
        sequence(:email){ |n| "person#{n}@example.com"}
        name {"Pepe"}
        provider {"facebook"}
        uid {"f492d5d408d365541fa67880f810b8c6"}
      end
    end
  end
  