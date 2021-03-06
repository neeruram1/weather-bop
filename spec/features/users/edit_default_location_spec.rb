require 'rails_helper'

RSpec.describe "Editing a default location" do
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

    @weather_music_data =
    {:data=>
    {:weather=>
    {:type=>"forecast",
     :attributes=>
      {:city_name=>"Denver",
       :country_name=>"US",
       :sunrise_time=>1600346605,
       :sunset_time=>1600391109,
       :main_description=>"Clear",
       :description=>"clear sky",
       :icon=>"01d",
       :temp=>74,
       :temp_min=>71,
       :temp_max=>78,
       :pressure=>1021,
       :humidity=>23,
       :visibility=>10000,
       :wind=>1.14}},
    :music=>
    {:type=>"tracks",
     :attributes=>
      [{:uri=>"spotify:track:62hpoPrA3rtfeX1aWONig5", :title=>"Split/Whole Time", :artist=>"Lil Yachty"},
       {:uri=>"spotify:track:0H9WHopZ62JeDaGau7REMw", :title=>"Shababs botten", :artist=>"Pashanim"},
       {:uri=>"spotify:track:5GBuCHuPKx6UC7VsSPK0t3", :title=>"Thotiana", :artist=>"Blueface"},
       {:uri=>"spotify:track:0utlOiJy2weVl9WTkcEWHy", :title=>"Neighbors", :artist=>"J. Cole"},
       {:uri=>"spotify:track:1eQBEelI2NCy7AUTerX0KS", :title=>"Ultralight Beam", :artist=>"Kanye West"},
       {:uri=>"spotify:track:0KuY5AT5pVnoVce9Wk9gJF", :title=>"Still Hold Up", :artist=>"Kevin Gates"},
       {:uri=>"spotify:track:32ypPhtgTaETvFn3ZIHXTW", :title=>"Fade Away", :artist=>"The Kid LAROI"},
       {:uri=>"spotify:track:2wBB2KKqtuK1fcxAiqbCSZ", :title=>"Hella Neck", :artist=>"Carnage"},
       {:uri=>"spotify:track:6KCt9V6Lev0M04rFUj8ANC", :title=>"Ice (feat. Gunna & Lil Baby)", :artist=>"Gucci Mane"},
       {:uri=>"spotify:track:5uZm7EFtP5aoTJvx5gv9Xf", :title=>"Jungle", :artist=>"A Boogie Wit da Hoodie"},
       {:uri=>"spotify:track:2h4cmbyb6S7e8igDZIITJU", :title=>"3 Headed Goat (feat. Lil Baby & Polo G)", :artist=>"Lil Durk"},
       {:uri=>"spotify:track:5lw8Mgb4LyhriPIC86gV6e", :title=>"RNP (feat. Anderson .Paak)", :artist=>"Cordae"},
       {:uri=>"spotify:track:1K5KBOgreBi5fkEHvg5ap3", :title=>"Life Is Good (feat. Drake)", :artist=>"Future"},
       {:uri=>"spotify:track:5hTpBe8h35rJ67eAWHQsJx", :title=>"Caroline", :artist=>"Aminé"},
       {:uri=>"spotify:track:7LRmDx4pMTQuOBBwRT1MCT", :title=>"Don't Rush (feat. Headie One)", :artist=>"Young T & Bugsey"},
       {:uri=>"spotify:track:6efkcs2aUBMFKxl0cl2JWQ", :title=>"Wild Irish Roses", :artist=>"Smino"},
       {:uri=>"spotify:track:6Q2qQTdLNfOubXXXzMNgwd", :title=>"Papi (feat. badmómzjay)", :artist=>"Monet192"},
       {:uri=>"spotify:track:2MF4HtZHBoUliOi9nOAbS0", :title=>"Purity (feat. Frank Ocean)", :artist=>"A$AP Rocky"},
       {:uri=>"spotify:track:6vN77lE9LK6HP2DewaN6HZ", :title=>"Yes Indeed", :artist=>"Lil Baby"},
       {:uri=>"spotify:track:4qikXelSRKvoCqFcHLB2H2", :title=>"Mercy", :artist=>"Kanye West"}]}}}
    end

    it "I see a button to edit my default location", :vcr do
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
        weather_music = WeatherMusic.new(@weather_music_data, neeru.default_location)

        expect(current_path).to eq('/dashboard')
        expect(neeru.default_location).to eq('denver')

        click_on('change default location')

        expect(current_path).to eq(user_edit_path)
        expect(page).to have_content('City')
        expect(page).to have_content('us state (optional)')

        expect(page).to have_select(:state)
        expect(page).to have_select(:country)
    end

    it "when I fill in Boston, Massachusetts United States in the edit form my default location changes to Boston, Massachusetts, US", :vcr do
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
        weather_music = WeatherMusic.new(@weather_music_data, neeru.default_location)

        click_on('change default location')
        expect(current_path).to eq(user_edit_path)
        fill_in :city, with: "Boston"
        select('Massachusetts', :from => :state)
        select('United States', :from => :country)
        click_on('change your default location')
        expect(current_path).to eq(dashboard_path)

        expect(page).to have_content("it's a great day to be in boston")
    end

    it "when I fill in Boston and United States in the edit form my default location becomes Boston, US", :vcr do
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
        weather_music = WeatherMusic.new(@weather_music_data, neeru.default_location)

        click_on('change default location')
        fill_in :city, with: "Boston"
        select('Massachusetts', :from => :state)
        select('United States', :from => :country)
        click_on('change your default location')
        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("it's a great day to be in boston")
  end
end
