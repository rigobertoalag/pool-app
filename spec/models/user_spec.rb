require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should_not allow_value("rigo@mail").for(:email) }
  it { should allow_value("rigo@mail.com").for(:email) }
  it { should validate_presence_of(:provider) }
  it { should validate_presence_of(:uid) }
  it { should validate_uniqueness_of(:email).case_insensitive }

  it "Deberia crear un usuario si el uid y el provider no existen" do 
    user = FactoryBot.create(:user)

    expect{
      User.from_omniauth({uid: "123456789", provider: "tester", info:{email: "mail2@mail.com"}})
    }.to change(User, :count).by(1)
  end

  it "Deberia encontrar un usuario si el uid y el provider ya existen" do
    user = FactoryBot.create(:user)

    expect{
      User.from_omniauth({uid: user.uid, provider: user.provider})
    }.to change(User, :count).by(0)
  end

  it "Deberia retornar el usuario encontrado si el uid y el provider ya existen" do 
    user = FactoryBot.create(:user)

    expect(
      User.from_omniauth({uid: user.uid, provider: user.provider})
    ).to eq(user)
  end
end