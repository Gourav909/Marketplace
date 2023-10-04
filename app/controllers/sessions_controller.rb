class SessionsController < DeviseTokenAuth::SessionsController

  def render_create_success
    render json: {
      success: true,
      data: UserSerializer.new(@resource)
    }
  end
end
