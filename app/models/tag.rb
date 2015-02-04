class Tag < ActiveRecord::Base
  VALID_TAG_REGEX = /\A([\w ])+\Z/i

  validates :name, presence: true, length: { maximum: 50 },
                   uniqueness: { case_sensitive: false },
                   format: { with: VALID_TAG_REGEX}

  has_many :active_relationships, class_name: "TagRelationship",
                                  foreign_key: "tag_id",
                                  dependent: :destroy
  # taggeds is awkward but idk how to make it better
  has_many :submissions, through: :active_relationships, source: :tagged

  has_many :users, -> { uniq }, through: :submissions, source: :user
end
