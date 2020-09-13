class SessionsController < ApplicationController
  def create
    @user = User.update_or_create(request.env['omniauth.auth'])
    session[:user_id] = @user.id
    redirect_to dashboard_path
  end
end
