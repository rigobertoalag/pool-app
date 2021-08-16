require 'rails_helper'

RSpec.describe Token, type: :model do
  it "should return valid when is not expired" do
    token = FactoryBot.create(:token, expires_at: DateTime.now + 1.minute)
    expect(token.is_valid?).to  eq(true)
  end
  it "should return invalid when is not expired" do
    token = FactoryBot.create(:token, expires_at: DateTime.now - 1.minute)
    expect(token.is_valid?).to  eq(false)
  end
end
