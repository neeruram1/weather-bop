require 'rails_helper'

describe PlaylistService do
  before :each do
    @token = "BQB7UoqyJtAyfPH3UFO_SGcS0nilrLoxq4kNXbAtJJd2GJbGRsiBsYgL6UmeR96ddqXIOtVHgMVL05Frg-Ck3AOECMuH9KpCpofeG-oBYmTPd12q9zJiqgRu1BxMEzBwAQGpQQQWmdvNJ7do9gm0mkLYC2k-QLoz2x_hruK3YI2kE2WKNQiYR55Xf1oV5jWMMY2o1ZwwsaBzOjUnqX9iGkZ3X5oJsmXBX_A1FfFzH9QaMa4"
  end
  context "instance methods" do
    context "#add_playlist_to_library" do
      it "returns movie data sorted by popularity", :vcr do
        service = PlaylistService.new
        playlist_name = "beat it"
        user_id = "bosigp0djzqxoyj6yq6sdzzaq"
        tracks =
        ["spotify:track:60ZZNXIdwgUGkVGRt7foLT",
         "spotify:track:40IQooNkPRVtn4zlE3ZFpA",
         "spotify:track:39hnH8WdPmNT3Q3yzwC9Rg",
         "spotify:track:7EoSDrwBPUBeBEORrpvgko",
         "spotify:track:5hTpBe8h35rJ67eAWHQsJx",
         "spotify:track:4qdgv45EPcQqpQ08tF34f8",
         "spotify:track:4UaWrzY75h1tAvlxa4NKP9",
         "spotify:track:0utlOiJy2weVl9WTkcEWHy",
         "spotify:track:5sqHFfmw7MMc1L85BN8802",
         "spotify:track:2fQrGHiQOvpL9UgPvtYy6G",
         "spotify:track:41LmqBEQojWdLobJyf2xjG",
         "spotify:track:1EaKU4dMbesXXd3BrLCtYG",
         "spotify:track:6plT7nFGiXKSBP9HFSI4ef",
         "spotify:track:4pAl7FkDMNBsjykPXo91B3",
         "spotify:track:3uya2Ph2zB84JMR28vqWK0",
         "spotify:track:5YEOzOojehCqxGQCcQiyR4",
         "spotify:track:16qYlQ6koFxYVbiJbGHblz",
         "spotify:track:2wBB2KKqtuK1fcxAiqbCSZ",
         "spotify:track:72UCHNyJcymw81x0AKevho",
         "spotify:track:62hpoPrA3rtfeX1aWONig5"]

        response = service.add_playlist_to_library(@token, playlist_name, user_id, tracks)

        expect(response).to be_a Hash
        expect(response[:data][:playlist][:attributes]).to have_key :status
        expect(response[:data][:playlist][:attributes]).to have_key :external_url
        expect(response[:data][:playlist][:attributes][:status]).to eq(201)
      end
    end
  end
end
