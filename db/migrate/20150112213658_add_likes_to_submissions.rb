class AddLikesToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :likes, :integer
  end
end
