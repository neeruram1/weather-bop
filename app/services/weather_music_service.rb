require 'rails_helper'

class WeatherMusicService
  def weather_music(token, location)
    to_json("/weather_playlist?q=#{location}&token=#{token}")
  end

  private

  def conn
    Faraday.new("#{ENV['WEATHER_MUSIC_DOMAIN']}")
  end

  def to_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
