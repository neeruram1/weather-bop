# README

Description
WeatherBop is an application that curates music based upon the synthesis of weather attributes specific to a given location and the audio features of a track. Through algorithms we are able to use Spotify's extensive breakdown of a song (tempo, energy, valence, mode, and speechiness) to directly coorelate with elements that comprise weather, namely, temperature, humidity and wind speed. An example of the relationship is that songs with a higher tempo (bpm) will be returned when the search location has current high windspeeds. The songs that are returned with matching weather characteristics come directly from the user's own collection of 'liked songs'. When created, the user is stored in our database with a default location of Denver. However, from the dashboard page they have the ability to both change their default location or simply search any place on the planet that they so choose. When they do either, the dashboard will immediately reload with a new playlist of songs reflecting the weather of the place they searched their. We have also addressed the possibility that a user does not have 'liked' songs in their spotify account. When this happens, the songs that are returned come from a random selection of genres and they also reflect the attributes of the current location be it the default location or a search. Finally, we have imported a Spotify player on the user's dashboard that gives them the ability to listen to the entire playlist or any song within it that they desire. 

Weather-bop is an application built using the frameworks of Rails and Sinatra, utilizing the coding languages Ruby, Javascript, HTML, and CSS. Authentication is handled using Spotify OAuth services, weather is returned by the Open Weather API, and tracks are curated from the Spotify API library.

To run WeatherBop on a local machine, navigate to the directory in which you would like the project to be located, then execute the following commands:

First: 
$ git clone git@github.com:neeruram1/weatherbop.git 
$ cd weatherbop
$ bundle install
$ rails db:create
$ rails db:migrate
$ bundle exec figaro install

Second: 
$ git clone git@github.com:sienna-kopf/weather_music2.git
$ cd weatherbop
$ bundle install
$ touch .env 



* Environment Variable Setup:
1. Sign Up on the following API:
- Spotify
-Add the following code snippet to your config/application.yml file. Make sure to insert the key/secret without the       alligator clips ( < > ).

SPOTIFY_CLIENT_ID: <insert>
SPOTIFY_CLIENT_SECRET: <insert>

2. Sign up for an api key from OpenWeatherApi.org
-Add the following code snippet to your .env file within weather_music2. Make sure to insert the key/secret without the       alligator clips ( < > ).
example: WEATHER_API_KEY=<key goes here>
  
Running Tests
To run the test suite, execute the following command: bundle exec rspec



Deployment
To view WeatherBop in development, execute the following command from the weatherbop project directory: rails s, in the weather_music directory: shotgun 
Next, in a browser, visit localhost:3000, to view the application. 

Tools Utilized:
Figaro
Faraday
Shoulda-Matchers
Spotify OAuth (with Omniauth gem)
Spotify API
Bootstrap
GitHub & GitHub Projects
RSpec
Capybara
Pry
RuboCop
Launchy
SimpleCov
PostgreSQL

Project Management
GitHub Project Board

Authors
Neeru Ram
Sienna kopf
Ashkan Abbasi
Joshua Tukman 

About
WeatherBop provides a curated music experience based on relationship between audio and weather attributes. 
