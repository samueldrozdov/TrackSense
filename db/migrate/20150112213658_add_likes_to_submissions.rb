class AddLikesToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :likes, :integer, default: 0
  end
end
