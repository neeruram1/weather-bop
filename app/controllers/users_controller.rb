class UsersController < ApplicationController
  def show
    binding.pry
    if current_user.access_token_expired?
      token = current_user.refresh_access_token
    else
      token = current_user.access_token
    end
    location = current_user.default_location
    weather_music_facade = WeatherMusicFacade.new(token, location).weather_music
  end
end
