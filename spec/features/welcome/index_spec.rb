require 'rails_helper'

RSpec.describe 'Login path' do
  before(:each) do
    @auth_data = {
        'provider'  => 'spotify',
        'info' => {
          'display_name' => 'Neeru Ram',
          'id'           => '12345',
          'email'         => 'neeram85@gmail.com'
        },
        'credentials' => {
          'token'         => "BQCC1XV_NnrWAgt1GloT6iPpcimdaQlQ-vcmZCYTjqqLY6HEIohT9T29gvnZgKYQpMJGiOpXLrrJI08fJUHC7yfR0A6JWRPqcZ6y2NZcfn6_oTik2JASHADUhz5pt8Q42CB17UxaAETvCqQdYOe3aRCNyw8KtiS9XaXXbsXTr6yON6r7Qyi5rLRYW9QOGKcJPAhttY29ujF82vA-CCcOGgiuX4vw76e3LoP3Em36f59Crpc",
          'refresh_token' => "AQAYaYXY6bvvILAJez7njQ7MzDCqDNS6A76kqkYek34mA_-6NPmOoTSs9Qt2XgicprO4hGlGRePvW9Auu1lIiT3cZW7cAaIa-XVDV5dsLi6uhSdaN8s1c60PWgNn2guxmcY",
        }
      }
  end

  it "Displays the name of the application" do
    visit root_path

    expect(page).to have_content("weather-bop")
  end

  it "New user can sign in with spotify", :vcr do
    OmniAuth.config.mock_auth[:spotify] = @auth_data

    visit root_path

    click_link('login')

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("welcome, #{@auth_data['info']['display_name']}".downcase)
  end

  it "Existing user can sign in with spotify", :vcr do
    neeru = User.create(
                spotify_id: @auth_data["info"]["id"],
                name: @auth_data["info"]["display_name"],
                access_token: @auth_data["credentials"]["token"],
                refresh_token: @auth_data["credentials"]["refresh_token"],
                email: @auth_data["info"]["email"]
              )
      OmniAuth.config.mock_auth[:spotify] = @auth_data

      visit root_path

      click_link('login')

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("welcome, #{neeru.name.downcase}")
  end

  it "has a link to register with spotify" do
    visit root_path

    expect(page).to have_content("don't have a spotify account?")
    expect(page).to have_link('register here', href: 'https://www.spotify.com/us/')
  end

  it "redirects to welcome page if authorization fails" do
    OmniAuth.config.mock_auth[:spotify] = :invalid_credentials

    visit root_path

    click_link('login')
    expect(current_path).to eq(root_path)
    expect(page).to have_content("invalid credentials, please try logging in again")
  end
end
