class SubmissionsController < ApplicationController

  def create

    # instantiate SoundCloud client
    client = SoundCloud.new(client_id: "9574e1c46dbd351816e7f8c373e6d22e")

    # resolve URL into Track object
    track = client.get("/resolve", url: submission_params[:external_link])
    byebug

    # grab values from object
    artist = track.user.username
    track_length = track.duration/1000 # convert from ms to seconds
    name = track.title

    @submission = current_user.submissions.build({ external_link: submission_params[:external_link],
                                                   artist: artist,
                                                   track_length: track_length,
                                                   name: name })
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
      params.require(:submission).permit(:external_link)
    end

end
