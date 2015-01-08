class Submission < ActiveRecord::Base
  belongs_to :user
  has_many :votes, as: :votable
  has_many :genres, through: :tagged

  # validations
  VALID_URL_REGEX = /\A(http(?:s)?\:\/\/[a-zA-Z0-9\-]+(?:\.[a-zA-Z0-9\-]+)*\.[a-zA-Z]{2,8}\/(.)*)\z/

  validates :user_id, presence: true
  validates :artist, presence: true
  validates :track_length, presence: true
  validates :external_link, presence: true, format: { with: VALID_URL_REGEX }
end
