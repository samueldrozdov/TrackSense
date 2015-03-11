class Track < ActiveRecord::Base

  has_many :submissions

  has_many :votes, as: :votable

  # validations
  VALID_URL_REGEX = /\A(http(?:s)?\:\/\/[a-zA-Z0-9\-]+(?:\.[a-zA-Z0-9\-]+)*\.[a-zA-Z]{2,8}\/(.)*)\z/

  validates :artist, presence: true
  validates :track_length, presence: true
  validates :external_link, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_URL_REGEX }
  validates :track_name, presence: true, uniqueness: { case_sensitive: false }

end
