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
          'token'         =>   "BQAVKD5MWLj4TBcLoYpLOxpqWe4bisQ2l--TNb8X5YWzyppzb9fehl-4Na6_5bQCDbY9AO_wr3rgk_wtHmGyu8GHL2Zv4ib2YQgw1zdVtM6JXObxTg439AHkWve6OdM-Dop021hNtp6U2lESqZvqu06cR0nvg72THeY",
          'refresh_token' => "AQARNCuLi0BndYr66W1QLQYMX9N6knDZ7yg5alYGlI_6de9pAyyvl7HKUP09kTvdT4dmHqSPsLDDLysZeijS-iBEBkgNWFgTTdtGiFl8WUAiydFHCIhMihr2X0QZBATG_uM",
        }
      }
  end

  it "Displays the name of the application" do
    visit root_path

    expect(page).to have_content("WeatherBop")
  end

  it "New user can sign in with spotify", :vcr do
    OmniAuth.config.mock_auth[:spotify] = @auth_data

    visit root_path

    click_link('login')

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("welcome, #{@auth_data['info']['display_name']}")
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
      expect(page).to have_content("welcome, #{neeru.name}")
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
