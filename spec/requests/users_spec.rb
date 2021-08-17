require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
    describe "POST /users" do
        before :each do
            auth = {provider: "twitter", uid: "123456789", info: { email: "u@mail3.com" } }
            post "/api/v1/users", {params: auth}
        end 
        
        it {have_http_status(200) }

        it {change(User,:count).by(1)}

        it "responds with the user found or created" do 
            json = JSON.parse(response.body)
            #puts "\n\n\n --#{json}-- \n\n\n"
            expect(json["email"]).to eq("u@mail3.com")
        end

    end
end