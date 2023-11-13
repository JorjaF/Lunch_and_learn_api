require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { User.new(name: "eric", email: "eric@eric.com", password: "password") }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
  end

  describe 'callbacks' do
    it 'generates an API key before creating the user' do
      user = User.new(name: "eric", email: "eric@eric.com", password: "password")
      user.save

      expect(user.api_key).to be_present
    end
  end
end
