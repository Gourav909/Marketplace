class ApplicationController < ActionController::Base
  protect_from_forgery

  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :type])
  end

  def page
    params[:page] || 1
  end

  def per_page
    params[:per] || 10
  end
end


