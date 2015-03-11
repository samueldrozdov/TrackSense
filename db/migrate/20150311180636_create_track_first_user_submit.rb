class CreateTrackFirstUserSubmit < ActiveRecord::Migration
  def change

    add_column :tracks, :discovered_by, :integer, :default => 0

  end
end
