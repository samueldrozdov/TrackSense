class Submission < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :votes, as: :votable
  has_many :genres, through: :tagged

  # validations
  VALID_URL_REGEX = /\A(http(?:s)?\:\/\/[a-zA-Z0-9\-]+(?:\.[a-zA-Z0-9\-]+)*\.[a-zA-Z]{2,8}\/(.)*)\z/

  validates :user_id, presence: true
  validates :artist, presence: true
  validates :track_length, presence: true
  validates :external_link, presence: true, uniqueness: { case_sensitive: true }, format: { with: VALID_URL_REGEX }
  validates :name, presence: true, uniqueness: { scope: :artist,
                                                 case_sensitive: true,
                                                 message: "This song has already been posted." }
  # remember to handle song non-uniqueness later by upvoting the post that already exists.
end
