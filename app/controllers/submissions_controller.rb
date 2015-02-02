class SubmissionsController < ApplicationController

  def create
    # get tags
    tag_names = (params[:tags][:comma_separated_tags]).split(",").map(&:strip)

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
      artwork_url = track.artwork_url
    else
      flash[:danger] = "Song not found"
      redirect_to root_url
      return
    end

    @submission = current_user.submissions.build({ external_link: submission_params[:external_link],
                                                   artist: artist,
                                                   track_length: track_length,
                                                   name: name,
                                                   artwork_url: artwork_url })
    if @submission.save(params[:submission])
      flash[:success] = "Post successful"

      # tag submission
      tag_names.each do |tag_name|
        tag = Tag.find_by(name: tag_name)

        # if tag exists, create relationship associating existing tag with submission
        if tag
          TagRelationship.new(tag_id: tag.id, tagged_id: @submission.id).save

        # otherwise create new tag
        else
          tag = @submission.tags.build(name: tag_name)
          tag.save

          TagRelationship.new(tag_id: tag.id, tagged_id: @submission.id).save
        end
      end
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

  def incrementPC
    song = Submission.find(params[:id])
    song.play_count = song.play_count + 1
    song.save
    render_text song.play_count
  end

  private

    def submission_params
      params.require(:submission).permit([:external_link, :tags])
    end

end
