require 'rails_helper'

RSpec.describe User, type: :model do
  it "must have a valid username" do
    user = FactoryBot.create(:user)
    expect(user.email).to eq("testing123@gmail.com")
  end

  it "must have a valid password" do
    user = FactoryBot.create(:user)
    expect(user.password).to eq("12345g")
  end
end
