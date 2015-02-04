class SubmissionsController < ApplicationController
include TracksHelper

  def create
    # get tags
    tag_names = (params[:tags][:comma_separated_tags]).split(",").map(&:strip)

    url = params[:tracks][:external_link]
    if (track_exists? url)
      #pull track id

      track_id = get_track_id url

    else
      #create new track

      # instantiate SoundCloud client
      client = SoundCloud.new(client_id: "9574e1c46dbd351816e7f8c373e6d22e")

      # try to resolve URL into Track object
      begin
        track = client.get("/resolve", url: url)
      rescue
        # if failure, redirect and return
        puts "hard error"
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
        puts "something wrong with track data"
        redirect_to root_url
        return
      end

      @track = Track.create!({ external_link: url,
                                      artist: artist,
                                track_length: track_length,
                                  track_name: name,
                                 artwork_url: artwork_url })

      if @track.save
        #can now create submission from track
        track_id = @track.id
      else
        flash[:danger] = "Something bad happened, try again!"
        redirect_to root_url
        return
      end
    end

    #create submission from track id

    @submission = current_user.submissions.build({ track_id: track_id,
                                                   group_id: 1 })

    if @submission.save()
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
    if !song.play_count
      song.play_count = 1
    end
    song.play_count = song.play_count + 1
    song.save
    render_text song.play_count
  end

  private

    def submission_params
      params.require(:submission).permit([:external_link, :tags])
    end

end
