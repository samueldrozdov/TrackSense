class GroupRelationship < ActiveRecord::Base
  belongs_to :group, class_name: "Group"
  belongs_to :member, class_name: "User"

  validates :user_id, presence: true
  validates :group_id, presence: true
end
