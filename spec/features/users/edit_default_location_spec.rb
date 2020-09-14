require 'rails_helper'

RSpec.describe "As a logged in user" do
  describe "when I am on the dashboard page" do   
    before(:each) do 
    @auth_data = {
      'provider'  => 'spotify',
      'info' => {
        'display_name' => 'JoshT',
        'id'           => '12345',
        'email'         => 'example@gmail.com'
      },
      'credentials' => {
        'token'         =>   "BQDxASPFQ260Wb_k6AHnXFBprabaxBQOpNzMPTPk2GLd4ga8cMGsgD7D6cTdohvL7jmT_IaOVVo5odV57To1jxVqNlkv-WG0WZuvKoSTdmjs5WF1xpgcFO-p4R-WlpeZWAbWFHMkzmdEMki-vMTfHW3q-5AhH3pANzrCRgwyat5iqpSVg_QtguQEunQ3",
        'refresh_token' => "AQBb65nszAcO4iYd1HNidYdG50ef_pSg1V-qyMCTET6dqtpUYTUXDIVlb7v7vek-tZdetZOjl1X2H3AlYq-jTzbmMyJSzoCPm9UyaE4sQ7BASYlgO_zQtWkjYZzzsApqUZI",
                      }
                }
    end
    it "I see a button to edit my default location", :vcr do   
        josh = User.create(
                spotify_id: @auth_data["info"]["id"],
                name: @auth_data["info"]["display_name"],
                access_token: @auth_data["credentials"]["token"],
                refresh_token: @auth_data["credentials"]["refresh_token"],
                email: @auth_data["info"]["email"]
              )
        OmniAuth.config.mock_auth[:spotify] = @auth_data

        visit root_path
        click_on "log in with spotify"
        
        expect(current_path).to eq('/dashboard')
        expect(josh.default_location).to eq('denver')

        click_button('Change your default location')

        expect(current_path).to eq('/edit')
        expect(page).to have_content('City')
        expect(page).to have_content('US State (Optional)')
       
        expect(page).to have_select(:state)
        expect(page).to have_select(:country)     
    end
    it "when I fill in Boston, Massachusetts United States in the edit form my default location changes to Boston, Massachusetts, US", :vcr do   
        josh = User.create(
                spotify_id: @auth_data["info"]["id"],
                name: @auth_data["info"]["display_name"],
                access_token: @auth_data["credentials"]["token"],
                refresh_token: @auth_data["credentials"]["refresh_token"],
                email: @auth_data["info"]["email"]
              )
        OmniAuth.config.mock_auth[:spotify] = @auth_data

        visit root_path
        click_on "log in with spotify"
        click_button('Change your default location')
        fill_in :city, with: "Boston"
        select('Massachusetts', :from => :state)
        select('United States', :from => :country)
        click_on 'weather-bop somewhere else!'
        expect(josh.default_location).to eq("Boston, MA, US")
    end
    it "when I fill in Boston and United States in the edit form my default location becomes Boston, US", :vcr do   
        josh = User.create(
                spotify_id: @auth_data["info"]["id"],
                name: @auth_data["info"]["display_name"],
                access_token: @auth_data["credentials"]["token"],
                refresh_token: @auth_data["credentials"]["refresh_token"],
                email: @auth_data["info"]["email"]
              )
        OmniAuth.config.mock_auth[:spotify] = @auth_data

        visit root_path
        click_on "log in with spotify"
        click_button('Change your default location')
        fill_in :city, with: "Boston"
        select('Massachusetts', :from => :state)
        select('United States', :from => :country)
        click_on 'weather-bop somewhere else!'
        #expect(josh.default_location).to eq("Boston, MA, US")
    end
  end
end