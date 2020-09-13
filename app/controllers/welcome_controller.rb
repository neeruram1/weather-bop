class WelcomeController < ApplicationController
  def index; end

  def failure
    redirect_to root_path
    flash[:message] = 'invalid credentials, please try logging in again'
  end
end
