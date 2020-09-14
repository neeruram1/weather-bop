class UsersController < ApplicationController
  def show
    @weather_music = WeatherMusicFacade.new(current_user.token, location).weather_music

    if @weather_music.nil?
      redirect_to dashboard_path
      flash[:errors] = 'invalid city'
    else
      @weather_music
    end
  end
end
