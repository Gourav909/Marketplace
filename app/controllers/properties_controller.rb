class PropertiesController < ApplicationController
  include Pagination
  include ApplicationMethods

  def index
    @properties = @properties.search(params[:search]).filter!(filter_params)
    @properties = @properties.page(page).per(per_page)
    render_success_response({
      properties: array_serializer.new(@properties.order(created_at: :desc), serializer: PropertySerializer, current_user: current_user )}, '', 200, page_meta(@properties)
    )
  end

  def show
    render_success_response({
      properties: single_serializer.new(@property, serializer: PropertySerializer,
        current_user: current_user )}
    )
  end

  def create
    property = current_user.properties.build(property_params)
    if property.save
      render_success_response({
        properties: single_serializer.new(property, serializer: PropertySerializer, current_user: current_user )}, nil, :created)
    else
      render_unprocessable_entity_response(property)
    end
  end

  def update
    if @property.update(property_params)
      render_success_response({
      properties: single_serializer.new(@property, serializer: PropertySerializer, current_user: current_user )}, status: :ok)
    else
      render_unprocessable_entity_response(@property)
    end
  end

  def destroy
    if @property.destroy
     render_success_response({ message: "Property removed successfully." })
    else
      render_unprocessable_entity_response(@property)
    end
  end

  private

    def property_params
      params.permit(:title, :price_per_month, :no_of_rooms, :property_type, :net_size, :description, :image, address_attributes: address_params)
    end

    def address_params
      [:id, :city_id, :district_id, :_destroy]
    end

    def filter_params
      params.slice(:property_type, :city, :district, :net_size, :rent_per_month)
    end
end
