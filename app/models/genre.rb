class Genre < ActiveRecord::Base
  has_many :submissions, through: :tagged

  validate :name, presence: true
end
