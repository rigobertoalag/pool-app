require 'rails_helper'

RSpec.describe MyApp, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:user) }

  it "Deberia generar un app_id antes de crear el registro" do
    my_app = FactoryBot.create(:my_app)
    expect(my_app.app_id).to_not be_nil
  end

  it "deberia generar un secret_key antes de crear el registro" do
    my_app = FactoryBot.create(:my_app)
    expect(my_app.app_id).to_not be_nil
  end

  it "deberia poder encontrar sus propios tokens" do 
    my_app = FactoryBot.create(:my_app)
    token = FactoryBot.create(:token, my_app: my_app, user: my_app.user)

    expect(my_app.is_your_token?(token)).to eq(true)
  end

  it "deberia retornar falso para is_your_token si el token no es de esta aplicacion" do 
    my_app = FactoryBot.create(:my_app)
    second_app = FactoryBot.create(:my_app, user: my_app.user)
    token = FactoryBot.create(:token, my_app: second_app, user: my_app.user)

    expect(my_app.is_your_token?(token)).to eq(false)
  end
end
