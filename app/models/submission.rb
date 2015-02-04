class Submission < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :track, dependent: :destroy

  has_many :votes, as: :votable
  has_many :active_relationships, class_name: "TagRelationship",
                                  foreign_key: "tagged_id",
                                  dependent: :destroy
  has_many :tags, through: :active_relationships, source: :tag


  # validations
  VALID_URL_REGEX = /\A(http(?:s)?\:\/\/[a-zA-Z0-9\-]+(?:\.[a-zA-Z0-9\-]+)*\.[a-zA-Z]{2,8}\/(.)*)\z/

  validates :group_id, presence: true
  validates :user_id, presence: true
  validates :track_id, presence: true
  # validates :artist, presence: true
  # validates :track_length, presence: true
  # validates :external_link, presence: true, uniqueness: { case_sensitive: true }, format: { with: VALID_URL_REGEX }
  # validates :name, presence: true, uniqueness: { scope: :artist,
  #                                               case_sensitive: false,
  #                                               message: "This song has already been posted." }
  # remember to handle song non-uniqueness later by upvoting the post that already exists.

  # helper methods

  def Submission.update_all_likes
    # avoid calling this if possible, it's an N+1 query / slow
    Submission.all.each do |submission|
      submission.update_score
    end
  end

  def update_likes
    self.likes = self.votes.count
    self.save
  end
end
