class UsersController < ApplicationController
  def show
    if params[:city].nil? == false && params[:country].nil? == false
      city = params[:city].downcase
      country = params[:country].downcase
      if params[:state].nil? == false
        state = params[:state].downcase
        location = "#{city}, #{state}, #{country}"
      else
        location = "#{city}, #{country}"
      end
    else
      location = current_user.default_location
    end
    @weather_music = WeatherMusicFacade.new(current_user.token, location).weather_music
  end
end
