# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) } # Assuming you have FactoryBot set up for User

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user.email = nil
      expect(user).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many properties' do
      expect(user).to have_many(:properties).dependent(:destroy)
    end

    it 'has many favourite properties' do
      expect(user).to have_many(:favourite_properties).dependent(:destroy)
    end

    it 'has many fav_properties through favourite_properties' do
      expect(user).to have_many(:fav_properties).through(:favourite_properties).source(:property)
    end

  end

  describe 'admin?' do
    it 'returns false' do
      expect(user.admin?).to be_falsey
    end
  end

  describe 'user?' do
    it 'returns true' do
      expect(user.user?).to be_truthy
    end
  end
end
