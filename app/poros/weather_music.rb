class WeatherMusic
  attr_reader :location,
              :forecast_city_name,
              :forecast_country_name,
              :forecast_description,
              :forecast_temp,
              :forecast_temp_min,
              :forecast_temp_max,
              :tracks

  def initialize(weather_music_info, location)
    @location = location
    @forecast_city_name = weather_music_info[:data][:weather][:attributes][:city_name]
    @forecast_country_name = weather_music_info[:data][:weather][:attributes][:country_name]
    @forecast_description = weather_music_info[:data][:weather][:attributes][:description]
    @forecast_temp = weather_music_info[:data][:weather][:attributes][:temp]
    @forecast_temp_min = weather_music_info[:data][:weather][:attributes][:temp_min]
    @forecast_temp_max = weather_music_info[:data][:weather][:attributes][:temp_max]

    binding.pry

    @tracks = weather_music_info[:data][:music][:attributes].map do |track_data|
      Track.new(track_data)
    end
  end
end
