class PlaylistService
  def add_playlist_to_library(token, playlist_name, user_id, tracks)
    to_json("/add_playlist_to_library?playlist_name=#{playlist_name}&user_id=#{user_id}&tracks=#{tracks}&token=#{token}")
  end

  private

  def conn
    Faraday.new(ENV['WEATHER_MUSIC_DOMAIN'])
  end

  def to_json(url)
    response = conn.post(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
