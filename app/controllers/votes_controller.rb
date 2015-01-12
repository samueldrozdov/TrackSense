class VotesController < ApplicationController
  def create
    if current_user
      @vote = current_user.votes.build(user_id: params[:user_id],
                                    votable_id: params[:votable_id],
                                    votable_type: params[:votable_type])
      @vote.save
    end
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def destroy
    vote = Vote.find(params[:id])
    if vote.user_id == current_user.id
      Vote.delete(params[:id])
    end
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end
end
