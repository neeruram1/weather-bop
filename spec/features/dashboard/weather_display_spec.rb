require 'rails_helper'

RSpec.describe 'Weather display' do
  before(:each) do
    auth_data = {
        'provider'  => 'spotify',
        'info' => {
          'display_name' => 'Neeru Ram',
          'id'           => '12345',
          'email'         => 'neeram85@gmail.com'
        },
        'credentials' => {
          'token'         => "BQDVbEKk7-SLk_WtcWTCRmb2GiaUrAbBmrBxBncReNXDIH_P4zBh2mn4i3U63LA9Lh19OUH38SAJXjfL7JmgvpT1YhbGs1Kev_DJb2rQ9kxCjsfTEnIxwLJLVNbW79_esQzyRjcRYJpt1u5zT7LVDSSTiMl8I2N9wx8",
          'refresh_token' => "AQA2wOXkEH0BRFmYJ2Ao0Sy-kJa_kciBk7qAfRIFwnqKaiGz-yAi2fl8g0M9rsx9DNqmtcWYE0PllwzluQjsysCFn1iGnigmSL41KJ3FKYbCRzIuwaR87_hMhvwAnLS9sik",
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
         :temp=>83,
         :temp_min=>81,
         :temp_max=>86,
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
      @weather_music = WeatherMusic.new(weather_music_data, @neeru.default_location)
  end

  it "shows my default location on the page", :vcr do
    visit dashboard_path

    expect(page).to have_content(@neeru.name)
    expect(page).to have_content("it's a great day to be in #{@neeru.default_location}")
  end

  it "shows the day's forecast for my default location", :vcr do

    visit dashboard_path

    within ".current-temp" do
      expect(page).to have_content("#{@weather_music.forecast_temp}")
    end

    within ".forecast-details" do
      expect(page).to have_content("city: #{@weather_music.forecast_city_name.downcase}")
      expect(page).to have_content("country: #{@weather_music.forecast_country_name.downcase}")
      expect(page).to have_content("description: #{@weather_music.forecast_description.downcase}")
      expect(page).to have_content("current low: #{@weather_music.forecast_temp_min}")
      expect(page).to have_content("current high: #{@weather_music.forecast_temp_max}")
    end
  end
end
