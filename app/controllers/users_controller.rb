class UsersController < ApplicationController
  def show
    city = params[:city]
    state = params[:state]
    country = params[:country]
    if !params.keys.include?("city") && !params.keys.include?("country") && !params.keys.include?("state")
      location = current_user.default_location
    elsif params.keys.include?("city") && params.keys.include?("country") && params.keys.include?("state")
      if city.empty? || country.empty?
        flash[:errors] = "please enter missing information"
        location = current_user.default_location
      else
        if state.empty? == false
          location = "#{city}, #{state}, #{country}".downcase
        else
          location = "#{city}, #{country}".downcase
        end
      end
    end
    @weather_music = WeatherMusicFacade.new(current_user.token, location).weather_music
  end
end
