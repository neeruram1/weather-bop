class UsersController < ApplicationController
  def show
    @weather_music = WeatherMusicFacade.new(current_user.token, current_user.default_location).weather_music
  end
  def update
    @user = User.find(current_user.id)
    if user_params[:state] == ""
       @user.update(default_location: "#{user_params[:city].strip}, #{user_params[:country]}")
      @user.save
    else
      @user.update(default_location: "#{user_params[:city].strip.downcase}, #{user_params[:state].downcase}, #{user_params[:country].downcase}")
      @user.save     
    end
    redirect_to dashboard_path
  end 
  
  private

  def user_params
    params.permit(:city, :state, :country)
  end 

end
