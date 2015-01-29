class TagRelationship < ActiveRecord::Base
  belongs_to :tag, class_name: "Tag"
  belongs_to :tagged, class_name: "Submission"

  validates :tag_id, presence: true
  validates :tagged_id, presence: true
end
