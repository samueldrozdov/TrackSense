class AddArtworkUrlToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :artwork_url, :string
  end
end
