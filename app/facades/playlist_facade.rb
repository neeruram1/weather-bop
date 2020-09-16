class PlaylistFacade
  def initialize(token, tracks, playlist_data)
    @token = token
    @location = playlist_data[:q].downcase
    @main_description = playlist_data[:main_description].downcase
    @user_id = playlist_data[:user_id]
    @tracks = tracks
    @playlist_service = PlaylistService.new
  end

  def post_playlist
    @playlist_service.add_playlist_to_library(@token, @location, @main_description, @user_id, @tracks)
  end
end
