require 'rails_helper'

RSpec.describe "creating a playlist" do
  before :each do
    auth_data = {
        'provider'  => 'spotify',
        'info' => {
          'display_name' => 'Neeru Ram',
          'id'           => "bosigp0djzqxoyj6yq6sdzzaq",
          'email'         => 'neeram85@gmail.com'
        },
        'credentials' => {
          'token'         => "BQDmQZTv04F3PXI606gvAmH-XozlpcY0cL4iHyToEm5a2R_h0bZIJ_Nts03v4dG1pIpTHRYppTz0sP-CDKUhp8gGUV08o4k_68JeQAnsz8VWv6bQiCMjHCxdpzwiuWb6z91P4Bn1BLlj56bLxapQCX7vUIcgqUszFJQJNhrSghTuu2KMKHiHxG62Yf0PqYiKhcYZzQ8-yt3l-cxfKv1EHv1aZpeRjm3R4FQB5kOCy2lbgro",
          'refresh_token' => "AQCrXzvctPR6izvf53idWEUuxNlXoUFRlhq6sU-T-aWSHZA7yZSQH6LmUIkHQLFAucaqj1jLirBp2OsCUVJ62jPkLmcJE42GSwpycDnD5t5PH-saxpgUJ2XuK3bZ2XB0Q1Q",
        }
      }

    weather_music_data =
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
       :temp_max=>77,
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
    @neeru = User.create(
                spotify_id: auth_data["info"]["id"],
                name: auth_data["info"]["display_name"],
                access_token: auth_data["credentials"]["token"],
                refresh_token: auth_data["credentials"]["refresh_token"],
                email: auth_data["info"]["email"]
              )
    OmniAuth.config.mock_auth[:spotify] = auth_data
    visit root_path
    click_link('login')
  end

  it "can save a list of tracks to their library as a playlist", :vcr do
    visit dashboard_path
    expect(page).to have_content(@neeru.name.downcase)
    expect(page).to have_content("it's a great day to be in #{@neeru.default_location}")

    click_link("save collection")

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('this playlist has now been added to your spotify library')
  end
end
