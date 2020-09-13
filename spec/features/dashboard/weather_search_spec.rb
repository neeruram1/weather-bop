require 'rails_helper'

RSpec.describe 'weather search' do
  describe "a user signs in with spotify and is redirected to the dashboard" do
    before :each do
      auth_data = {
          'provider'  => 'spotify',
          'info' => {
            'display_name' => 'Neeru Ram',
            'id'           => '12345',
            'email'         => 'neeram85@gmail.com'
          },
          'credentials' => {
            'token'         => "BQBgRK3l13SDv3C_j-TskA09sHjmdsjM3Z0KZFj8oOtPyN2SIkrx0BJLrsgOTp502cuA7BOuFXASWWQGxjp22bE75ZyCj2tNexl0lJZLYaAVBKnAmj9YYWKi0W8wyUkCWdA9Iro_FvA5AmrKuhxIHL4_cODYnZOetOOWoO9aKp_f_-BH7Uy74vgL4fiKWCK2",
            'refresh_token' => "AQBwFM93zDFLDw6T-bBXpmyMcY9efV_1iIqZ8o6oB9awx5kOYnXpLmPoAaOPKQyLhuwRqHYfNoj-7Mp35uciHlF11fLvmagBSEVwUUP9AiaOQyB3eLQ-QuEgnj2PRq_UU1Y",
          }
        }

      weather_music_data = {:data=>
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
        @neeru = User.create(
                    spotify_id: auth_data["info"]["id"],
                    name: auth_data["info"]["display_name"],
                    access_token: auth_data["credentials"]["token"],
                    refresh_token: auth_data["credentials"]["refresh_token"],
                    email: auth_data["info"]["email"]
                  )
        OmniAuth.config.mock_auth[:spotify] = auth_data
        visit root_path
        click_on 'log in with spotify'
        @weather_music = WeatherMusic.new(weather_music_data)
    end

    it "user selects a new location from drop down menus to display new weather and music information", :vcr do
      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("welcome, #{@neeru.name}")
      expect(page).to have_content("it's a great day to be in denver")

      fill_in :city, with: "San Francisco"
      select "California", from: :state
      select "United States", from: :country
      click_on "weather-bop somewhere else!"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("it's a great day to be in san francisco")
    end
  end
end
