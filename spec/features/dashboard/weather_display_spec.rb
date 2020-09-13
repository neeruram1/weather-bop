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
          'token'         =>   "BQA_NUSfNQn_NKZTuP5_ZHtUkITI-czG-51v5sxKEoUmWfVg2SrwDthQx_2T0ERy23m_B91gGdCVWJCBgIby4mnjhyPRMXnGRflXGbq31BjuWPCrJtBD7-sJiXpFhv7DcpmrZvUY7VoZp8AIL4mdSSM0IzEvqykd2n4",
          'refresh_token' => "AQDuEdneaQB3-SEukrWxbpQzqtmbYGtI_BEf5wHcx3k2kZ4m1fYAzwAaQLE1r8B_WaiHDUR6qvmUfSK9j1w3UafcEbftGVu4sqEFtdaBHFbuJN5cx1kLwsji5DvQglPHbag",
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
      save_and_open_page
    end
  end
end
