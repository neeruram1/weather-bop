class WelcomeController < ApplicationController
  def index; end

  def failure
    redirect_to '/'
    flash[:message] = 'invalid credentials, please try logging in again'
  end
end
