class Vote < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :votable, polymorphic: true, dependent: :destroy

  validates :votable_id, presence: true
  validates :user_id, presence:true
  validates :votable_type, presence: true
end
