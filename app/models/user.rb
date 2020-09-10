class User < ActiveRecord::Base
  def self.find_or_create_from_auth(auth)
    User.find_or_create_by(
      spotify_id: auth["info"]["id"],
      name: auth["info"]["display_name"],
      access_token: auth["credentials"]["token"],
      refresh_token: auth["credentials"]["refresh_token"],
      email: auth["info"]["email"],
    )
  end
end
