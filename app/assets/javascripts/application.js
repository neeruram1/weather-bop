// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require activestorage
//= require_tree
//= require jquery3
//= require jquery_ujs

//= require_tree ./channels
// require_tree .

window.onSpotifyWebPlaybackSDKReady = () => {
  const token = 'BQBblinrpEEDZgSS-0LLMhPbt87nc8cuhAfSA_JYQ7oXVfdSwmdzA4qexcDEQe6e-ybtvFqXEhrfbY4bR_DamwLiRPVqruG3vGUamdIe5EOMEqi9C8Reh7VpyqP2J-QKxjL2GTswvJrRuAEQgmNgWiu2zIzp-yrruY8';
  const player = new Spotify.Player({
    name: 'Web Playback SDK Quick Start Player',
    getOAuthToken: cb => { cb(token); }
  });

  // Error handling
  player.addListener('initialization_error', ({ message }) => { console.error(message); });
  player.addListener('authentication_error', ({ message }) => { console.error(message); });
  player.addListener('account_error', ({ message }) => { console.error(message); });
  player.addListener('playback_error', ({ message }) => { console.error(message); });

  // Playback status updates
  player.addListener('player_state_changed', state => { console.log(state); });

  // Ready
  player.addListener('ready', ({ device_id }) => {
    console.log('Ready with Device ID', device_id);
  });

  // Not Ready
  player.addListener('not_ready', ({ device_id }) => {
    console.log('Device ID has gone offline', device_id);
  });

  // Connect to the player!
  player.connect();
};
