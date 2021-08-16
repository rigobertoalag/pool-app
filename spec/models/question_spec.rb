require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of :description }
  it { should validate_presence_of :my_pool }
  it { should validate_length_of(:description).is_at_least(10) }
end