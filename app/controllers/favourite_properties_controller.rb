class FavouritePropertiesController < ApplicationController
  include Pagination
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_favourite_property, only: [:destroy]

  def index
    favourite_property_ids = current_user.favourite_properties.where(is_favourite: true).ids
    favourite_properties = Property.where(id: favourite_property_ids)

    paginated_properties = paginatable_array(favourite_properties)
    serialized_properties = searilzer(PropertySerializer, paginated_properties)

    render json: { favourite_properties: serialized_properties, meta: page_meta(paginated_properties) }
  end

  def create
    favourite_property = current_user.favourite_properties.new(favourite_property_params)
    if favourite_property.save
      render json: favourite_property, serializer: FavouritePropertySerializer, status: :created
    else
      render json: { errors: favourite_property.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  def destroy
    if @favourite_property.destroy
      render json: { message: "Favourite Property removed successfully."}
    else
      render json: { errors: @favourite_property.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def favourite_property_params
    params.permit(:user_id, :property_id, :is_favourite)
  end

  def set_favourite_property
    @favourite_property = FavouriteProperty.find_by(property_id: params[:id], user_id: current_user.id)
    unless @favourite_property.present?
      return render json: {errors: [{message: 'Favourite Property not found.'}]}, status: :unprocessable_entity
    end
  end
end


