class Track
  attr_reader :uri,
              :title,
              :artist

  def initialize(track_data)
    @uri = track_data[:uri]
    @title = track_data[:title]
    @artist = track_data[:artist]
  end
end
