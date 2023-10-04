class CitiesController < ApplicationController
  def index
    cities = City.all
    render json: cities, each_serializer: CitySerializer, status: :ok
  end
end
