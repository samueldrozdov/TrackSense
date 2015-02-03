class AddTrackIdToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :track_id, :integer
  end
end
