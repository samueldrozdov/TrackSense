class Group < ActiveRecord::Base

  belongs_to :user

  has_many :active_relationships, class_name: "User",
                                 foreign_key: "user_id",
                                   dependent: :destroy
  has_many :users, through: :active_relationships, source: :member
  has_many :submissions

  validates :name, presence: true, uniqueness: { case_sensitive: false }

end
