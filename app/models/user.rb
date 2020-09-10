class User < ActiveRecord::Base
  def self.update_or_create(auth)
    user = User.find_by(spotify_id: auth["info"]["id"]) || User.new

    user.attributes = {
      spotify_id: auth["info"]["id"],
      name: auth["info"]["display_name"],
      access_token: auth["credentials"]["token"],
      refresh_token: auth["credentials"]["refresh_token"],
      email: auth["info"]["email"]
    }
    user.save!
    user
  end
end
