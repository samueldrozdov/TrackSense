class Track < ActiveRecord::Base

  has_many :submissions

  validates :artist, presence: true
  validates :track_length, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }

end
