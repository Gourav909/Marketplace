# spec/models/property_spec.rb
require 'rails_helper'

RSpec.describe Property, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_one(:address).dependent(:destroy) }
    it { should have_one_attached(:image) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
  end

describe 'enums' do
    it 'defines the property_type enum with expected string values' do
      expected_enum = {
        'residential' => 'residential',
        'office' => 'office',
        'retail' => 'retail',
        'home' => 'home'
      }
      expect(described_class.property_types).to eq(expected_enum)
    end
  end

  describe 'scopes' do
    let(:user) { create(:user) }

    describe '.filter_by_property_type' do
      let!(:residential_property) { create(:property, property_type: 'residential', user: user) }
      let!(:office_property) { create(:property, property_type: 'office', user: user) }

      it 'filters properties by property type' do
        filtered_properties = Property.filter_by_property_type('residential')
        expect(filtered_properties).to include(residential_property)
        expect(filtered_properties).not_to include(office_property)
      end
    end
  end
end
