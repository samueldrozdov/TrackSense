class VotesController < ApplicationController

  def create
    if logged_in?
      @vote = Vote.find_by(user_id: current_user.id, votable_id: params[:votable_id])


      if @vote

        @vote.destroy

      else

        @vote = current_user.votes.build(user_id: params[:user_id],
                                      votable_id: params[:votable_id],
                                    votable_type: params[:votable_type])

        @vote.save

        respond_to do |format|
          format.html
          format.js
        end
      end

    end
  end

  def destroy
    # prevent users from forging requests to delete other user's votes
    Vote.delete(params[:id]) if current_user.id == vote.user_id
    respond_to do |format|
      format.html
      format.js
    end
  end
end
