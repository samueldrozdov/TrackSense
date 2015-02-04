module TracksHelper

  #returns true if track exists, else false
  def track_exists?(url)
    Track.where(external_link: url).any?()
  end

  #returns track's id
  def get_track_id(url)
    tracks = Track.where(external_link: url)
    tracks[0].id
  end
end
