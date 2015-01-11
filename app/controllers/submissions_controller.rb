class SubmissionsController < ApplicationController

  def create
    @submission = current_user.submissions.build
    if @submission.save(params[:submission])
      flash[:success] = "Post successful"
    else
      # error submitting
      flash[:danger] = "Song has already been posted"
    end
    redirect_to root_url
  end

  def destroy
    # actually implement this later
    redirect_to root_url
  end

end
