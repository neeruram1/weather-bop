class UsersController < ApplicationController
  def show
    @weather_music = WeatherMusicFacade.new(current_user.token, current_user.default_location).weather_music
  end
end
