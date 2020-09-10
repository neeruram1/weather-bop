require 'rails_helper'

RSpec.describe 'Login path' do
  it "Displays the name of the application" do
    visit '/'

    expect(page).to have_content("WeatherBop")
  end

  it "New user can sign in with spotify" do
    auth_data = {
        'provider'  => 'spotify',
        'info' => {
          'display_name' => 'Neeru Ram',
          'id'           => '12345',
        },
        'credentials' => {
          'token'         => '12345',
          'refresh_token' => '23456',
          'email'         => 'neeram85@gmail.com'
        }
      }
    OmniAuth.config.mock_auth[:spotify] = auth_data

    visit '/'

    click_on "Log In With Spotify"

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("welcome, #{auth_data['info']['display_name']}")
  end

  it "Existing user can sign in with spotify" do
    auth_data = {
        'provider'  => 'spotify',
        'info' => {
          'display_name' => 'Neeru Ram',
          'id'           => '12345',
        },
        'credentials' => {
          'token'         => '12345',
          'refresh_token' => '23456',
          'email'         => 'neeram85@gmail.com'
        }
      }

    neeru = User.create(
                spotify_id: auth_data["info"]["id"],
                name: auth_data["info"]["display_name"],
                access_token: auth_data["credentials"]["token"],
                refresh_token: auth_data["credentials"]["refresh_token"],
                email: auth_data["info"]["email"]
              )
      OmniAuth.config.mock_auth[:spotify] = auth_data

      visit '/'

      click_on "Log In With Spotify"

      expect(current_path).to eq("/dashboard")
      expect(page).to have_content("welcome, #{neeru.name}")
  end
end
