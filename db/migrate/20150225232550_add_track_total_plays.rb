class AddTrackTotalPlays < ActiveRecord::Migration
  def change
    add_column :tracks, :total_plays, :integer, :default => 0
  end
end
