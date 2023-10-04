# spec/models/address_spec.rb
require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'associations' do
    it { should belong_to(:property) }
    it { should belong_to(:city) }
    it { should belong_to(:district) }
  end

  describe 'delegations' do
    let(:city) { City.new(name: 'Example City') }
    let(:district) { District.new(name: 'Example District') }
    let(:address) { Address.new(city: city, district: district) }

    it 'delegates the name attribute to city with a prefix' do
      expect(address.city_name).to eq('Example City')
    end

    it 'delegates the name attribute to district with a prefix' do
      expect(address.district_name).to eq('Example District')
    end
  end
end
