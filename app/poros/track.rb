class Track
  attr_reader :id,
              :title,
              :artist
              
  def initialize(track_data)
    @id = track_data[:id]
    @title = track_data[:title]
    @artist = track_data[:artist]
  end
end
