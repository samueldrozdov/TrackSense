class AddGroupIdToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :group_id, :integer
  end
end
