class UsersController < ApplicationController
  def show
    if current_user.access_token_expired?
      token = current_user.refresh_access_token
    else
      token = current_user.access_token
    end
    location = 'Denver'
    weather_music_facade = WeatherMusicFacade.new(token, location).weather_music
  end
end
