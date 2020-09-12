class WeatherMusicFacade
  attr_reader :location,
              :token

  def initialize(token, location)
    @location = location
    @token = token
    @weather_music_service = WeatherMusicService.new
  end

  def weather_music
    WeatherMusic.new(results_weather_music)
  end

  def results_weather_music
    @weather_music_service.weather_music(@token, @location)
  end
end
