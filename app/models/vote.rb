class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :votable_id, presence: true
  validates :user_id, presence: true, uniqueness: { scope: [:votable_type, :votable_id] }
  validates :votable_type, presence: true
end
