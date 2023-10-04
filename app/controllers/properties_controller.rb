class PropertiesController < ApplicationController
  include Pagination
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    @properties = params[:search] ? search_by_params : filters
    paginated_properties = paginatable_array(@properties)
    serialized_properties = searilzer(PropertySerializer, paginated_properties)

    render json: { properties: serialized_properties, meta: page_meta(paginated_properties) }
  end

  def show
    render json: @property, serializer: PropertySerializer, status: :ok
  end

  def create
    property = current_user.properties.new(property_params)
    if property.save
      render json: property, serializer: PropertySerializer, status: 201
    else
      render json: { errors: property.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @property.update(property_params)
      render json: @property, serializer: PropertySerializer , status: :ok
    else
      render json: { errors: @property.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @property.destroy
      render json: { message: "Property removed successfully." }
    else
      render json: { errors: @property.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def filters
    filters = params["filter_by"]
    return Property.all unless filters
    conditions = []

    filters.each do |column, value|
      if ["city_id", "district_id"].include?(column)
        conditions << ["addresses.#{column} = ?", value]
      else
        conditions << ["#{column} = ?", value]
      end
    end

    Property.joins(:address).where(conditions.map(&:first).join(" AND "), *conditions.map(&:last)).distinct
  end

  def search_by_params
    return Property.all unless params[:search].present?

    search_params = { search: "%#{params[:search]}%" }

    min_price = params[:min_price].to_i
    max_price = params[:max_price].to_i
    min_size  = params[:min_size].to_i
    max_size  = params[:max_size].to_i

    query = Property.joins(address: { city: :districts })
      .where(
        'cities.name LIKE :search OR ' \
        'districts.district_name LIKE :search OR ' \
        '(price_per_month BETWEEN :min_price AND :max_price) OR ' \
        'net_size BETWEEN :min_size AND :max_size OR ' \
        'property_type LIKE :search OR ' \
        'no_of_rooms LIKE :search',
        search_params.merge(min_price: min_price, max_price: max_price, min_size: min_size, max_size: max_size)
      )

    query
  end

  def property_params
    params.permit(:title, :price_per_month, :no_of_rooms, :property_type, :net_size, :description, :image, address_attributes: address_params)
  end

  def address_params
    [:id, :city_id, :district_id, :_destroy]
  end
end
