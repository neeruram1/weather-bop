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
        'token'         =>    "BQCsNLq1jC5LWiT4R1o0IZxm4Dad69YXA0F8vUZDijsUJfNQh-pSc5HzhmBHxfZ3XRRIO3OcM3GmcZZ17P3WG8UAk_C7DB01kxDcAPb52wjOY8R0yQ5AC1P7qB-e3WNyteK0khoOfUTre_39Wr1NlDqIEiDSDVw9Jfk",
        'refresh_token' => "AQBb65nszAcO4iYd1HNidYdG50ef_pSg1V-qyMCTET6dqtpUYTUXDIVlb7v7vek-tZdetZOjl1X2H3AlYq-jTzbmMyJSzoCPm9UyaE4sQ7BASYlgO_zQtWkjYZzzsApqUZI",
                      }
                }
        @weather_music_data = {:data=>
          {:weather=>
            {:type=>"forecast",
              :attributes=>
              {:city_name=>"Denver",
                :country_name=>"US",
                :sunrise_time=>1600000784,
                :sunset_time=>1600045907,
                  :description=>"few clouds",
                  :temp=>81,
                  :temp_min=>78,
                  :temp_max=>83,
                  :pressure=>1026,
                  :humidity=>16,
                  :visibility=>10000,
                  :wind=>5.82}},
                  :music=>{:type=>"playlist", :attributes=>{:id=>"2L8jO4NEg9G6pjZAxv4Hdt", :uri=>"spotify:playlist:2L8jO4NEg9G6pjZAxv4Hdt"}}}}
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
        click_link('login')
        weather_music = WeatherMusic.new(@weather_music_data, josh.default_location)

        expect(current_path).to eq('/dashboard')
        expect(josh.default_location).to eq('denver')

        click_button('change your default location')

        expect(current_path).to eq(user_edit_path)
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
        click_link('login')
        weather_music = WeatherMusic.new(@weather_music_data, josh.default_location)

        click_button('change your default location')
        expect(current_path).to eq(user_edit_path)
        fill_in :city, with: "Boston"
        select('Massachusetts', :from => :state)
        select('United States', :from => :country)
        click_on 'change your default location'
        expect(current_path).to eq(dashboard_path)

        expect(page).to have_content("it's a great day to be in boston")
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
        click_link('login')
        weather_music = WeatherMusic.new(@weather_music_data, josh.default_location)

        click_button('change your default location')
        fill_in :city, with: "Boston"
        select('Massachusetts', :from => :state)
        select('United States', :from => :country)
        click_on 'change your default location'
        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("it's a great day to be in boston")
    end
  end
end
