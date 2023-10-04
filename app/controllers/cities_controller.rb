class CitiesController < ApplicationController
  include ApplicationMethods

  def index
    cities = City.all
    render_success_response({
      cities: array_serializer.new(cities, serializer: CitySerializer)}
    )
  end
end
