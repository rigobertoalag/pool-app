require 'rails_helper'

RSpec.describe MyPool, type: :model do
  it { should validate_presence_of :title }
  it { should belong_to(:user) }
  it { should validate_presence_of :description}
  it { should validate_length_of(:title).is_at_least(10) }
  it { should validate_length_of(:description).is_at_least(20) }
  it { should validate_presence_of :expires_at }
  it { should validate_presence_of :user }

  it "should return valid when is not expired" do
    my_pool = FactoryBot.create(:my_pool, expires_at: DateTime.now + 1.minute)
    expect(my_pool.is_valid?).to  eq(true)
  end
  it "should return invalid when is not expired" do
    my_pool = FactoryBot.create(:my_pool, expires_at: DateTime.now - 1.minute)
    expect(my_pool.is_valid?).to  eq(false)
  end
end
