class FavouritePropertiesController < ApplicationController
  include Pagination
  include ApplicationMethods

  before_action :set_favourite_property, only: [:destroy]

  def index
    fav_properties = current_user.fav_properties
    fav_properties = fav_properties.page(page).per(per_page)
    render_success_response({
      properties: array_serializer.new(fav_properties, serializer: PropertySerializer, current_user: current_user )}, '', 200, page_meta(fav_properties)
    )
  end

  def create
    favourite_property = current_user.favourite_properties.new(favourite_property_params)
    if favourite_property.save
      render_success_response({
      properties: single_serializer.new(favourite_property, serializer: FavouritePropertySerializer,
        current_user: current_user )}, status: :created)
    else
      render_unprocessable_entity_response(favourite_property)
    end
  end

  def destroy
    if @favourite_property.destroy
     render_success_response({ message: "Favourite Property removed successfully." })
    else
      render_unprocessable_entity_response(@favourite_property)
    end
  end

  private

  def favourite_property_params
    params.permit(:property_id, :is_favourite)
  end

  def set_favourite_property
    @favourite_property = FavouriteProperty.find_by(property_id: params[:property_id], user_id: current_user.id)
    return render_unprocessable_entity('Record not found!') unless @favourite_property.present?
  end
end


