class AddTrackPriority < ActiveRecord::Migration
  def change
    add_column :tracks, :priority, :integer, :default => 0
  end
end
