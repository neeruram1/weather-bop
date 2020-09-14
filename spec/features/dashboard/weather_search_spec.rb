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
            'token'         => "BQCm4Qs11NcRI8EBZd8sPWDD3tz1rqmUGwqf0ynAhVZrLim7B_i14fehieM0v8iL9A7VNQ74ZgiSEpMMizijAGZSTW_wdkvQy8NlX8qFHgu0-SGV2R5N2WL2KBR1FCGiUslT-y7j7X1FieO9SvZeEKSzWSufXfrj5p4",
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
        @weather_music = WeatherMusic.new(weather_music_data, @neeru.default_location)
    end

    it "user searches new location with city state and country from drop down menus", :vcr do
      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("welcome, #{@neeru.name}")
      expect(page).to have_content("it's a great day to be in denver")
      within ".forecast-details" do
        expect(page).to have_content("city: denver")
        expect(page).to have_content("country: us")
      end

      fill_in :city, with: "San Francisco"
      select "California", from: :state
      select "United States", from: :country
      click_on "weather-bop somewhere else!"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("it's a great day to be in san francisco")

      within ".forecast-details" do
        expect(page).to have_content("city: san francisco")
        expect(page).to have_content("country: us")
      end
    end

    it "user searches new location with city and country from drop down menus", :vcr do
      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("welcome, #{@neeru.name}")
      expect(page).to have_content("it's a great day to be in denver")
      within ".forecast-details" do
        expect(page).to have_content("city: denver")
        expect(page).to have_content("country: us")
      end

      fill_in :city, with: "London"
      select "United Kingdom", from: :country
      click_on "weather-bop somewhere else!"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("it's a great day to be in london")

      within ".forecast-details" do
        expect(page).to have_content("city: london")
        expect(page).to have_content("country: gb")
      end
    end

    it "user tries to search a new location with only city resulting in flash message", :vcr do
      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("welcome, #{@neeru.name}")
      expect(page).to have_content("it's a great day to be in denver")
      within ".forecast-details" do
        expect(page).to have_content("city: denver")
        expect(page).to have_content("country: us")
      end

      fill_in :city, with: "San Francisco"
      click_on "weather-bop somewhere else!"

      expect(page).to have_content("please enter missing information")

      within ".forecast-details" do
        expect(page).to have_content("city: denver")
        expect(page).to have_content("country: us")
      end
    end

    it "user tries to search a new location with only state resulting in flash message", :vcr do
      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("welcome, #{@neeru.name}")
      expect(page).to have_content("it's a great day to be in denver")
      within ".forecast-details" do
        expect(page).to have_content("city: denver")
        expect(page).to have_content("country: us")
      end

      select "California", from: :state
      click_on "weather-bop somewhere else!"

      expect(page).to have_content("please enter missing information")

      within ".forecast-details" do
        expect(page).to have_content("city: denver")
        expect(page).to have_content("country: us")
      end
    end

    it "user tries to search a new location with only country resulting in flash message", :vcr do
      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("welcome, #{@neeru.name}")
      expect(page).to have_content("it's a great day to be in denver")
      within ".forecast-details" do
        expect(page).to have_content("city: denver")
        expect(page).to have_content("country: us")
      end

      select "United States", from: :country
      click_on "weather-bop somewhere else!"

      expect(page).to have_content("please enter missing information")

      within ".forecast-details" do
        expect(page).to have_content("city: denver")
        expect(page).to have_content("country: us")
      end
    end

    it "user tries to search a new location with only city state or country state resulting in flash message", :vcr do
      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("welcome, #{@neeru.name}")
      expect(page).to have_content("it's a great day to be in denver")
      within ".forecast-details" do
        expect(page).to have_content("city: denver")
        expect(page).to have_content("country: us")
      end

      fill_in :city, with: "San Francisco"
      select "California", from: :state
      click_on "weather-bop somewhere else!"

      expect(page).to have_content("please enter missing information")
      visit dashboard_path

      select "California", from: :state
      select "United States", from: :country
      click_on "weather-bop somewhere else!"

      expect(page).to have_content("please enter missing information")

      within ".forecast-details" do
        expect(page).to have_content("city: denver")
        expect(page).to have_content("country: us")
      end
    end

    it "user tries to search a garbage city resulting in flash message", :vcr do
      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("welcome, #{@neeru.name}")
      expect(page).to have_content("it's a great day to be in denver")
      within ".forecast-details" do
        expect(page).to have_content("city: denver")
        expect(page).to have_content("country: us")
      end

      fill_in :city, with: "hadsfhueueaa"
      select "California", from: :state
      select "United States", from: :country
      click_on "weather-bop somewhere else!"

      expect(page).to have_content("invalid city")

      within ".forecast-details" do
        expect(page).to have_content("city: denver")
        expect(page).to have_content("country: us")
      end
    end

    it "user tries to search without entering a city or state resulting in flash message", :vcr do
      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("welcome, #{@neeru.name}")
      expect(page).to have_content("it's a great day to be in denver")
      within ".forecast-details" do
        expect(page).to have_content("city: denver")
        expect(page).to have_content("country: us")
      end

      select "United States", from: :country
      click_on "weather-bop somewhere else!"

      expect(page).to have_content("please enter missing information")

      within ".forecast-details" do
        expect(page).to have_content("city: denver")
        expect(page).to have_content("country: us")
      end
    end
  end
end
