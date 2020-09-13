class UsersController < ApplicationController
  def show
    if current_user.access_token_expired?
      token = current_user.refresh_token
    else
      token = current_user.access_token
    end
    location = current_user.default_location
    @weather_music = WeatherMusicFacade.new(token, location).weather_music
  end
end
