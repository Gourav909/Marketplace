class UsersController < ApplicationController
  include ApplicationMethods

  def get_current_user
    render_success_response({
      user: single_serializer.new(current_user, serializer: UserSerializer)}
    )
  end
end
