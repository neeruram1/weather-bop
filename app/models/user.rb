class User < ApplicationRecord
  def self.update_or_create(auth)
    user = User.find_by(spotify_id: auth['info']['id']) || User.new

    user.attributes = {
      spotify_id: auth['info']['id'],
      name: auth['info']['display_name'],
      access_token: auth['credentials']['token'],
      refresh_token: auth['credentials']['refresh_token'],
      email: auth['info']['email']
    }
    user.save!
    user
  end

  def access_token_expired?
    (Time.current - updated_at) > 3300
  end

  def token
    if access_token_expired?
      refresh_token
    else
      access_token
    end
  end
end
