require 'rails_helper'

RSpec.describe 'welcome page' do
  before(:each) do
    @auth_data = {
      'provider'  => 'spotify',
      'info' => {
        'display_name' => 'Neeru Ram',
        'id'           => '12345',
        'email'         => 'neeram85@gmail.com'
      },
      'credentials' => {
        'token'         => "BQCxovdHWKObnNt5D_myJiNr8dQ3vF37Fdgk6EtDNQNEPjv3976T3IRrpio9OTjQhmdoZpeMpE9iZjA64Eff1wvcNY49q8KCEhbMxPizF5FNI9Ib82YiCRKFoaLsPjWqckw8eiL0j7WC7ZYECktS4TUvF7sSD2IvD-joLa-ZjqWV2uMkBlojFkY6id0c-hNHwPXg1vxhmrs1G2a5dWD3qZG5EJw",
        'refresh_token' => "AQASR4N-RUH3OR-QQGuHmQdziXPVuv3hQvKKFsjsHQ_MCSjMIB3tGAEafLjES6QpgHbHREAuCe5XvGMGFc1Vv6EIFz0GPAY2L1iv6SbZmynMNqylMffjpKdV4jxLCbAnWuQ",
      }
    }
  end
  describe 'login path' do
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

    it "redirects to welcome page if authorization fails" do
      OmniAuth.config.mock_auth[:spotify] = :invalid_credentials

      visit root_path

      click_link('login')
      expect(current_path).to eq(root_path)
      expect(page).to have_content("invalid credentials, please try logging in again")
    end
  end

  describe 'logout path' do
    it "user can logout", :vcr do
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
      expect(page).to_not have_link('login')
      expect(page).to have_link('change default location')
      click_link('logout')

      expect(current_path).to eq(root_path)

      expect(page).to_not have_link('logout')
      expect(page).to_not have_link('change default location')

      expect(page).to have_link('login')
    end
  end
end
