class Playlist
  attr_reader :status,
              :external_url

  def initialize(playlist_data)
    @status = playlist_data[:playlist][:attributes][:status]
    @external_url = playlist_data[:playlist][:attributes][:external_url]
  end
end
