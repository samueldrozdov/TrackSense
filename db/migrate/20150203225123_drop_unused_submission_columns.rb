class DropUnusedSubmissionColumns < ActiveRecord::Migration
  def change
    remove_column :submissions, :external_link
    remove_column :submissions, :artist
    remove_column :submissions, :track_length
    remove_column :submissions, :artwork_url
  end
end
