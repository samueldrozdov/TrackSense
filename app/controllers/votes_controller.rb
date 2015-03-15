class VotesController < ApplicationController

  def create
    if logged_in?
      @vote = Vote.find_by(user_id: current_user.id, votable_id: params[:votable_id])
      @track = Track.find_by(id: params[:votable_id])
      current_user.like_track(@track)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    if logged_in?
      @vote = Vote.find_by(user_id: current_user.id, votable_id: params[:votable_id])
      @track = Track.find_by(id: params[:votable_id])
      current_user.unlike_track(@track)

      respond_to do |format|
        format.html
        format.js
      end
    end
  end

end
