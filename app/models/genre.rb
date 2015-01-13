class Genre < ActiveRecord::Base
  has_many :submissions, through: :tagged

  validates :name, presence: true
end
