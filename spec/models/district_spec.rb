require 'rails_helper'
RSpec.describe District, type: :model do
  describe 'associations' do
    it { should belong_to(:city)}
  end
end
