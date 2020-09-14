class WeatherMusic
  attr_reader :location,
              :forecast_city_name,
              :forecast_country_name,
              :forecast_description,
              :forecast_temp,
              :forecast_temp_min,
              :forecast_temp_max,
              :playlist_id,
              :playlist_uri

  def initialize(weather_music_info, location)
    @location = location
    @forecast_city_name = weather_music_info[:data][:weather][:attributes][:city_name]
    @forecast_country_name = weather_music_info[:data][:weather][:attributes][:country_name]
    @forecast_description = weather_music_info[:data][:weather][:attributes][:description]
    @forecast_temp = weather_music_info[:data][:weather][:attributes][:temp]
    @forecast_temp_min = weather_music_info[:data][:weather][:attributes][:temp_min]
    @forecast_temp_max = weather_music_info[:data][:weather][:attributes][:temp_max]
    @playlist_id = weather_music_info[:data][:music][:attributes][:id]
    @playlist_uri = weather_music_info[:data][:music][:attributes][:uri]
  end
end
