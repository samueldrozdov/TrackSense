class Group < ActiveRecord::Base

  belongs_to :user

  has_many :users
  has_many :submissions

  validates :name, presence: true, uniqueness: { case_sensitive: false }

end
