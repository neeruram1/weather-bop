require 'rails_helper'

RSpec.describe 'Login path' do
  it "Displays the name of the application" do
    visit '/'

    expect(page).to have_content("WeatherBop")
  end
end
