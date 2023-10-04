require 'rails_helper'
RSpec.describe City, type: :model do
  describe 'associations' do
    it { should have_many(:districts)}
  end
end
