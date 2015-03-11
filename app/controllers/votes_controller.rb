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
      end
    end

    respond_to do |format|
      format.html
      format.js
    end

    if params[:votable_type] = :Submission
      Submission.find(params[:votable_id]).update_likes
    end
  end

  def destroy
    if logged_in?
      @vote = Vote.find_by(user_id: current_user.id, votable_id: params[:votable_id])

      if @vote
        @vote.destroy

        respond_to do |format|
          format.html
          format.js
        end
      else
        self.create
      end
    end

    if params[:votable_type] = :Submission
      Submission.find(params[:votable_id]).update_likes
    elsif params[:votable_type] = :Track

    end
  end
end
