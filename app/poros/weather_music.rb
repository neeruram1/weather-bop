class WeatherMusic
  attr_reader :description
  
  def initialize(weather_music_info)
    binding.pry
    @description = weather_music_info[:description]
  end
end
