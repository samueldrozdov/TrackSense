module TracksHelper

  #returns true if track exists
  def track_exists?(url)
    Track.where(external_link: url).any?()
  end

  #returns track's id
  def get_track_id(url)
    tracks = Track.where(external_link: url)
    tracks[0].id
  end

  #background task that decays tracks popularity
  def self.update_priority

    Track.find_each do |track|

      penalty = track.priority / 10
      votes = Vote.where(votable_id: track.id, votable_type: :Track).count
      track.priority = votes - penalty < 0 ? 0 : (votes - penalty)
      track.save

    end

  end
end
