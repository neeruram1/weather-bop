class WeatherMusicFacade
  attr_reader :location,
              :token

  def initialize(token, location)
    @location = location
    @token = token
    @weather_music_service = WeatherMusicService.new
  end

  def weather_music
    if results_weather_music[:data][:type] == "error"
      # flash[:errors] = results_weather_music[:data][:attributes][:message]
      # redirect_to dashboard_path
    else
      WeatherMusic.new(results_weather_music, @location)
    end
  end

  def results_weather_music
    @weather_music_service.weather_music(@token, @location)
  end
end
