# weather-bop

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]

<img src="https://public.boxcloud.com/api/2.0/internal_files/736697301031/versions/784486980631/representations/jpg_paged_2048x2048/content/1.jpg?access_token=1!pxtkQ1otdLMNEHaXj5cvw8kIoUEdgYwkE859aA2R7fwI-ptJHejj9SGrbxkHv-lU86UHTl-y6aHoHw1Picaig3OY_HO5OmvhJ8jQd2fn_Ikvc5Mwnpuj58EeOJBNMnOz2P58lfV134EgVJb3IpZhwvSxXbDNBxhr83In6FQ1V1rW8oh_wHe2Mzkpb-scRXygzUGe0WlIOmteAJdhm9ZakjplNqL8IqyN_hAh-i3MO4C49GSD3cH2BYk8vcCvfxIMoMrd-r90ttdQdV4ZMjiNOUlV9FaF5WJ1emnBYDsINpovvrHlpBZu0JOiBofDRirmXFEDOsXWf-t7GVeiWGB2xAG4CX4p8PNZM4YEmtHicwagWsUaw-4VsQ3mVDamlxumz1oQRuyaFcUwpo8NqntePJFMs3WEgeBkXOHb-BaGY-mbSlBB3uh46Tv5-eKH3dhSb_rTT4kyPB06-g3NuOIHd_DBN8H0GI4NJSUkC_UNMJFWFaWQZQMK7WNQ66HP4IT7itwnQvTNfXHKFSLuNy0N4NPCcsTvUqLwL8ym-CDhiGr9cIGKGjUMdcbxWTFPtv3XzBh0Rxpal-S0vIMzdJ0lL3ef6fNTFPp3YWSU5495SoBY8KtYvzArfyKzzzWHYjikbCuxwJs7DjdUU7TQX7gK_uXEReg45_eW200J40_T1dI84Nia&box_client_name=box-content-preview&box_client_version=2.52.0" alt="weather-bop" width="418px" height="185px">

## Table of Contents

- [Overview](#overview)
- [Project story](#project-story)
- [Getting Started](#getting-started)
- [Tools Utilized](#tools-utilized)
- [Future Improvements](#future-improvements)
- [Contributing](#contributing)

# README

### Overview

[weather-bop](https://weather-bop.herokuapp.com/) is an 11-day, four-person project during Mod 3 of 4, for Turing School's Back End Engineering Program.

Our challenge was to create a web application from idea to inception. Project requirements included: authentication with a third-party service, consuming an API, and solving a real-world problem.

[**View our deployed version of the weather-bop**](https://weather-bop.herokuapp.com/)

### Project Story

[weather-bop](https://weather-bop.herokuapp.com/) is an application that curates music based upon the synthesis of weather attributes specific to a given location and the audio features of a track. Through algorithms we are able to use Spotify's extensive breakdown of a song (tempo, energy, valence, mode, and speechiness) to directly correlate with elements that comprise weather, namely, temperature, humidity and wind speed. An example of the relationship is that songs with a higher tempo (bpm) will be returned when the search location has current high windspeeds. The songs that are returned with matching weather characteristics come directly from the user's own collection of 'liked songs'. When created, the user is stored in our database with a default location of Denver. However, from the dashboard page they have the ability to both change their default location or simply search any place on the planet that they so choose. When they do either, the dashboard will immediately reload with a new playlist of songs reflecting the weather of the place they searched their. We have also addressed the possibility that a user does not have 'liked' songs in their spotify account. When this happens, the songs that are returned come from a random selection of genres and they also reflect the attributes of the current location be it the default location or a search. Finally, we have imported a Spotify player on the user's dashboard that gives them the ability to listen to the entire playlist or any song within it that they desire. 

### Getting Started:

To run [weather-bop](https://github.com/neeruram1/weather-bop) on a local machine, navigate to the directory in which you would like the project to be located, then execute the following commands:  

**For the weather-bop Rails App:**
```
$ git clone git@github.com:neeruram1/weather-bop.git 
$ cd weatherbop
$ bundle install
$ rails db:create
$ rails db:migrate
$ bundle exec figaro install
```

**For the Sinatra Microservice:** 
```
$ git clone git@github.com:sienna-kopf/weather_music2.git
$ cd weatherbop
$ bundle install
$ touch .env 
```

**Environment Variable Setup:**

Sign Up on the following API:   
[Spotify](https://developer.spotify.com/documentation/web-api/quick-start/)   
Add the following code snippet to your config/application.yml file in weatherbop.    
Make sure to insert the key/secret without the alligator clips ( < > ).

```
SPOTIFY_CLIENT_ID: <insert>
SPOTIFY_CLIENT_SECRET: <insert>
```

Sign up for the following API:    
[OpenWeather](https://home.openweathermap.org/users/sign_up)    
Add the following code snippet to your .env file in weather_music2.      
Make sure to insert the key/secret without the alligator clips ( < > ).

```
WEATHER_API_KEY=<insert>
```

### Tools Utilized:
- Figaro
- Faraday
- Shoulda-Matchers
- Spotify OAuth (with Omniauth gem)
- Spotify API
- Bootstrap
- GitHub & GitHub Projects
- RSpec
- Capybara
- Pry
- RuboCop
- Launchy
- SimpleCov
- PostgreSQL
- Heroku

### Future Improvements
- Implement the Spotify Web Playback SDK 
- Improve the weather -> audio features algorithm 
- Improve UX with Javascript

### Contributing
👤 **Neeru Ram**
- Github: [neeruram1](https://github.com/neeruram1)

👤 **Sienna Kopf**
- Github: [sienna-kopf](https://github.com/sienna-kopf)

👤 **Ashkan Abbassi**
- Github: [ashkanthegreat](https://github.com/ashkanthegreat) 

👤 **Joshua Tukman**
- Github: [joshua-tukman](https://github.com/joshua-tukman)




<!-- MARKDOWN LINKS & IMAGES -->

[contributors-shield]: https://img.shields.io/github/contributors/neeruram1/weather-bop.svg?style=flat-square
[contributors-url]: https://github.com/neeruram1/weather-bop/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/neeruram1/weather-bop.svg?style=flat-square
[forks-url]: https://github.com/neeruram1/weather-bop/network/members
[stars-shield]: https://img.shields.io/github/stars/neeruram1/weather-bop.svg?style=flat-square
[stars-url]: https://github.com/neeruram1/weather-bop/stargazers
[issues-shield]: https://img.shields.io/github/issues/neeruram1/weather-bop.svg?style=flat-square
[issues-url]: https://github.com/neeruram1/weather-bop/issues
