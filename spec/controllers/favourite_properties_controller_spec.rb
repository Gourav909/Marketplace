require 'rails_helper'

RSpec.describe FavouritePropertiesController, type: :controller do
  login_admin

  let(:user) { create(:user, type: 'User') }
  let(:property) { create(:property, user: Admin.last, property_type: "residential") }
  let(:favourite_property) { create(:favourite_property, user: Admin.last, property_id: property.id) }


  describe "GET #index" do
    context "as a normal user" do
      it "creates a new favourite property" do
        get :index
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "POST #create" do
    context "as a normal user" do
      it "creates a new favourite property" do
        favourite_property_params = attributes_for(:favourite_property)
        expect do
          post :create, params: { favourite_property: favourite_property_params, property_id: property.id }, format: :json
        end.to change(FavouriteProperty, :count).by(1)
        expect(response).to have_http_status(:ok)
      end
    end

    context "when favourite property params are invalid" do
      it "returns an unprocessable entity response" do
        favourite_property_params = attributes_for(:favourite_property)
        post :create, params: { favourite_property: favourite_property_params, property_id: 0}, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    context "Remove from favourites" do
      it "Should decrement by 1" do
        favourite_property
        expect do
          delete :destroy, params: { property_id: property.id }, format: :json
        end.to change(FavouriteProperty, :count).by(-1)
      end
    end
  end
end
