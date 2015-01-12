class AddVotableIdToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :votable_id, :integer
  end
end
