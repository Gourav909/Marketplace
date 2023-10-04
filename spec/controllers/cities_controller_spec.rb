require 'rails_helper'

RSpec.describe CitiesController, type: :controller do
  let(:admin_user) { create(:user, type: 'Admin') }
  let(:user) { create(:user, type: 'User') }
  let (:city){ create(:city) }
  let (:district){ create(:district) }
  let(:property) { create(:property, user: admin_user, property_type: "residential", address_attributes: {city_id: city.id, district_id: district.id }) }

  login_admin

  describe "GET #index" do
    context "index of city" do
      it "index of city" do
        get :index
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
