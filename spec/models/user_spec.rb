require 'rails_helper'

describe User do
  describe 'methods' do
    describe 'instance methods' do
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

        @neeru = User.create(
                    spotify_id: auth_data["info"]["id"],
                    name: auth_data["info"]["display_name"],
                    access_token: auth_data["credentials"]["token"],
                    refresh_token: auth_data["credentials"]["refresh_token"],
                    email: auth_data["info"]["email"],
                    updated_at: "2020-09-17 12:37:00 -0600"
                  )
      end
      describe '#token' do
        it 'refreshes token if expired' do
          expect(@neeru.token).to eq("AQCrXzvctPR6izvf53idWEUuxNlXoUFRlhq6sU-T-aWSHZA7yZSQH6LmUIkHQLFAucaqj1jLirBp2OsCUVJ62jPkLmcJE42GSwpycDnD5t5PH-saxpgUJ2XuK3bZ2XB0Q1Q")
        end
      end
    end
  end
end
