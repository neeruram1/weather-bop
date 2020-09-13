require 'rails_helper'

RSpec.describe 'Login path' do
  it "Displays the name of the application" do
    visit '/'

    expect(page).to have_content("WeatherBop")
  end

  it "New user can sign in with spotify" do
    json_response = File.read('./spec/fixtures/login.json')
    stub_request(:get, "http://localhost:9393/weather_playlist?q=denver&token=12345").        
      to_return(status: 200, body: json_response, headers: {})
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

    click_on "log in with spotify"

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("welcome, #{auth_data['info']['display_name']}")
  end

  it "Existing user can sign in with spotify" do
    json_response = File.read('./spec/fixtures/login.json')
    stub_request(:get, "http://localhost:9393/weather_playlist?q=denver&token=BQDQHnbOhRJivg8SvBKcBFFl7mgVcCjI3SiQUMc36VTNdBp3HyjyRHyykhkXWvCGOCga9UXEi5_1NYA7RTsN-0g32TRhhAQ7cABBTvcekGkyU3ecbrPQbwAhp7vAKHRBTCHPtn7bHTtGpPyAKl-0ZkC7HvfBh4YpnnTQ_Ic0BpqGAsVOkgZEnVaMWXJV").
      to_return(status: 200, body: json_response, headers: {})
    auth_data = {
        'provider'  => 'spotify',
        'info' => {
          'display_name' => 'JoshT',
          'id'           => '4y7xa2pyzvkf8c08rpubdinej',
        },
        'credentials' => {
          'token'         => 'BQDQHnbOhRJivg8SvBKcBFFl7mgVcCjI3SiQUMc36VTNdBp3HyjyRHyykhkXWvCGOCga9UXEi5_1NYA7RTsN-0g32TRhhAQ7cABBTvcekGkyU3ecbrPQbwAhp7vAKHRBTCHPtn7bHTtGpPyAKl-0ZkC7HvfBh4YpnnTQ_Ic0BpqGAsVOkgZEnVaMWXJV',
          'refresh_token' => 'AQB0Cnlae3Y6l-aHeXNkbsuG6JYr-9kyIX05KZQ1jW3yeaPTT_jkVx3GKVegF7S7kxqROKD3QyZINtOn56rSZAg_w88BuPKllGck_DryueXApMnMTeWipasdngtjUgUvmq0',
          'email'         => 'josh.tukman@gmail.com'
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

      click_on "log in with spotify"

      expect(current_path).to eq("/dashboard")
      expect(page).to have_content("welcome, #{neeru.name}")
  end

  it "has a link to register with spotify" do
    visit '/'

    expect(page).to have_content("don't have a spotify account?")
    expect(page).to have_link('register here', href: 'https://www.spotify.com/us/')
  end

  it "redirects to welcome page if authorization fails" do
    OmniAuth.config.mock_auth[:spotify] = :invalid_credentials

    visit '/'

    click_on 'log in with spotify'
    expect(current_path).to eq('/')
    expect(page).to have_content("invalid credentials, please try logging in again")
  end
end
