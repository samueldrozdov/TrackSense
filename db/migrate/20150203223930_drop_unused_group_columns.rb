class DropUnusedGroupColumns < ActiveRecord::Migration
  def change
    remove_column :groups, :submission_id
    remove_column :groups, :user_id
  end
end
