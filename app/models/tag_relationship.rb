class TagRelationship < ActiveRecord::Base
  belongs_to :tag, class_name: "Tag"
  belongs_to :tagged, class_name: "Submission"
end
