class PlaylistController < ApplicationController
  def create
    tracks = JSON.parse(params[:tracks]).map {|track| track["uri"] }
    response = PlaylistFacade.new(current_user.token, tracks, playlist_params).post_playlist
    binding.pry
  end

  private

  def playlist_params
    params.permit(:q, :main_description, :user_id)
  end
end
