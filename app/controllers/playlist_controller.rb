class PlaylistController < ApplicationController
  def create
    playlist_name = "its a great day for #{params[:main_description]} weather in #{params[:q]}"

    response = PlaylistFacade.new(current_user.token, playlist_name, playlist_params).status

    redirect_to dashboard_path

    if response == 201
      flash[:success] = 'this playlist has now been added to your spotify library'
    else
      flash[:error] = 'something went wrong! keep on weather-boppin'
    end
  end

  private

  def playlist_params
    params.permit(:user_id, :tracks)
  end
end
