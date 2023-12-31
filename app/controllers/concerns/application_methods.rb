
module ApplicationMethods
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    load_and_authorize_resource
    around_action :handle_exceptions
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found
    rescue_from CanCan::AccessDenied do |exception|
      render_unprocessable_entity('You are not authorized user to perform this action!')
    end
  end

  private

  # Catch exception and return JSON-formatted error
  def handle_exceptions
    begin
      yield
    rescue ActiveRecord::RecordInvalid => e
      render_unprocessable_entity_response(e.record) && return
    rescue ArgumentError => e
      @status = 400
    rescue StandardError => e
      @status = 500
    end
    detail = {detail: e.try(:message)}
    detail.merge!(trace: e.try(:backtrace))
    json_response({ success: false, message: e.class.to_s, errors: [detail] }, @status) unless e.class == NilClass
  end

  def render_unprocessable_entity_response(resource)
    json_response({
      success: false,
      message: 'Validation failed',
      errors: ValidationErrorsSerializer.new(resource).serialize
    }, 422)
  end

  def render_unprocessable_entity(message)
    json_response({
      success: false,
      message: message,
      errors: [message]
    }, 422) and return true
  end

  def render_success_response(resources = {}, message = "", status = 200, meta = {})
    json_response({
      success: true,
      data: resources,
      meta: meta
    }, status)
  end

  def json_response(options = {}, status = 500)
    render json: JsonResponse.new(options), status: status
  end

  def render_unauthorized_response(message = {})
    json_response({
      success: false,
      message: 'You are not authorized.',
      errors: [message]
    }, 401)
  end

  def array_serializer
    ActiveModel::Serializer::CollectionSerializer
  end

  def single_serializer
    ActiveModelSerializers::SerializableResource
  end

  def not_found(message = {})
    json_response({
      success: false,
      message: ['Record not found'],
      errors: message,
    }, 404)
  end
end
