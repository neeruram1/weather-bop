require 'rails_helper'

RSpec.describe PlaylistFacade do
  before :each do
    token = "BQDmQZTv04F3PXI606gvAmH-XozlpcY0cL4iHyToEm5a2R_h0bZIJ_Nts03v4dG1pIpTHRYppTz0sP-CDKUhp8gGUV08o4k_68JeQAnsz8VWv6bQiCMjHCxdpzwiuWb6z91P4Bn1BLlj56bLxapQCX7vUIcgqUszFJQJNhrSghTuu2KMKHiHxG62Yf0PqYiKhcYZzQ8-yt3l-cxfKv1EHv1aZpeRjm3R4FQB5kOCy2lbgro"
    playlist_name = "party time"
    playlist_data = {
      user_id: "bosigp0djzqxoyj6yq6sdzzaq",
      tracks: "spotify:track:16PmczUxlX7dpr6ror6pXd,spotify:track:4Q3N4Ct4zCuIHuZ65E3BD4,spotify:track:2fOlBMkWR7lXJfqp5VTbDG,spotify:track:1lOe9qE0vR9zwWQAOk6CoO,spotify:track:7fBKbK8897K5V5zgr7ymIz,spotify:track:6nsyYPCDUSacgXci9mvWln,spotify:track:37b1KAbfOZeBzeMB0LGO3g,spotify:track:4TMYf4SaVCnW4bLwC9NtiX,spotify:track:4pCEIQ6wBVuaJdER5bALtO,spotify:track:41LmqBEQojWdLobJyf2xjG,spotify:track:72UCHNyJcymw81x0AKevho,spotify:track:0GwYkXgQdqY4dyRffHw3HT,spotify:track:6vN77lE9LK6HP2DewaN6HZ,spotify:track:3R9j8urSPiBbapNbyuSYkE,spotify:track:2fQrGHiQOvpL9UgPvtYy6G,spotify:track:5hTpBe8h35rJ67eAWHQsJx,spotify:track:5tFep7dXGd7vEJ668wTPux,spotify:track:5lw8Mgb4LyhriPIC86gV6e,spotify:track:577YBGuskWkVDCxZrLRB4v,spotify:track:1b9Ab3ogNZcmcFEu2AjKhi"
      }

    playlist_service = PlaylistService.new
    @facade = PlaylistFacade.new(token, playlist_name, playlist_data)
  end
  
  it "returns a json response with status and external url for a playlist", :vcr do
    response = @facade.post_playlist

    expect(response).to be_a Hash
    expect(response[:data][:playlist][:attributes]).to have_key :status
    expect(response[:data][:playlist][:attributes]).to have_key :external_url
    expect(response[:data][:playlist][:attributes][:status]).to eq(201)
  end
  it "returns the status code of a post request to fill a playlist with tracks", :vcr do
    status = @facade.status

    expect(status).to eq(201)
  end
end
