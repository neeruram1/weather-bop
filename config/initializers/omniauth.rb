require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Spotify < OmniAuth::Strategies::OAuth2
      option :name, 'spotify'

      option :client_options, {
        site:          'https://api.spotify.com/v1/',
        authorize_url: 'https://accounts.spotify.com/authorize',
        token_url:     'https://accounts.spotify.com/api/token'
      }

      info do
         {
           :name => raw_info['name'],
           :email => raw_info['email']
         }
      end

      def info
        @raw_info ||= access_token.get('me').parsed
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'], scope: %w(
    playlist-read-private
    user-read-private
    user-read-email
    user-library-read
    streaming
  ).join(' ')
end
