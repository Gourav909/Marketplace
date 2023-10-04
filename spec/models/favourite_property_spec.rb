# spec/models/favourite_property_spec.rb
require 'rails_helper'

RSpec.describe FavouriteProperty, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:property) }
  end

  describe 'validations' do
    subject { described_class.new(user_id: 1, property_id: 1) }

    it { should validate_uniqueness_of(:user_id).scoped_to(:property_id) }
  end
end
