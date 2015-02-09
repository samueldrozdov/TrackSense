class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string   "external_link"
      t.string   "artist"
      t.float    "track_length"
      t.string   "track_name"
      t.string   "artwork_url"

      t.timestamps null: false
    end
  end
end
