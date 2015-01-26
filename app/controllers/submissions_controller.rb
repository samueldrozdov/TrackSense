class SubmissionsController < ApplicationController

  def create

    # instantiate SoundCloud client
    client = SoundCloud.new(client_id: "9574e1c46dbd351816e7f8c373e6d22e")

    # try to resolve URL into Track object
    begin
      track = client.get("/resolve", url: submission_params[:external_link])
    rescue
      # if failure, redirect and return
      flash[:danger] = "Song not found"
      redirect_to root_url
      return
    end

    # resolved url must be track
    if track.user && track.duration && track.title
      # grab values from track object (guaranteed to exist at this point)
      artist = track.user.username
      track_length = track.duration/1000 # convert from ms to seconds
      name = track.title
    else
      flash[:danger] = "Song not found"
      redirect_to root_url
      return
    end

    @submission = current_user.submissions.build({ external_link: submission_params[:external_link],
                                                   artist: artist,
                                                   track_length: track_length,
                                                   name: name })
    if @submission.save(params[:submission])
      flash[:success] = "Post successful"
    else
      # only real error here should be in the case of duplicates--will handle these soon(tm)
      flash[:danger] = "Post failed"
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
