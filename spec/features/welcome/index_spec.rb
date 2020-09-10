require 'rails_helper'

RSpec.describe 'Login path' do
  it "Displays the name of the application" do
    visit '/'

    expect(page).to have_content("WeatherBop")
  end

  it "has a login with spotify link" do
    visit '/'

    click_on "Log In With Spotify"

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("welcome, Neeru")
  end
end
