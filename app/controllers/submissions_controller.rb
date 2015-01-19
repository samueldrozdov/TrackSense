class SubmissionsController < ApplicationController

  def create
    @submission = current_user.submissions.build(submission_params)
    if @submission.save(params[:submission])
      flash[:success] = "Post successful"
    else
      # create errors partial soon
      flash[:danger] = "#{@submission.errors.messages.count} errors"
    end
    redirect_to root_url
  end

  def destroy
    Submission.find(params[:id]).destroy
    flash[:success] = "Post deleted"
    redirect_to root_url
  end

  private

    def submission_params
      params.require(:submission).permit(:external_link, :name, :artist, :track_length)
    end

end
