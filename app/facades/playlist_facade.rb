class PlaylistFacade
  def initialize(token, tracks, playlist_name, playlist_data)
    @token = token
    @playlist_name = playlist_name.downcase
    @user_id = playlist_data[:user_id]
    @tracks = tracks
    @playlist_service = PlaylistService.new
  end

  def post_playlist
    @playlist_service.add_playlist_to_library(@token, @playlist_name, @user_id, @tracks)
  end

  def status
    post_playlist[:data][:playlist][:attributes][:status]
  end
end
