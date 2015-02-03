class GroupUserSubmissionRelationship < ActiveRecord::Migration
  def change
    add_column :groups, :user_id, :integer
    add_column :groups, :submission_id, :integer
  end
end
