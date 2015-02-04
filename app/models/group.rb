class Group < ActiveRecord::Base

  belongs_to :user

  has_many :members, class_name: "GroupRelationship",
                      dependent: :destroy
  has_many :users, through: :members
  has_many :submissions

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def member?(user)
    users.include?(user)
  end

end
