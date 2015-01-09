class Genre < ActiveRecord::Base
  has_many :submissions, through: :tagged
end
