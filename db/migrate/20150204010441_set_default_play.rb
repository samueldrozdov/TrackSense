class SetDefaultPlay < ActiveRecord::Migration
  def change
    remove_column :submissions, :play_count
    add_column :submissions, :play_count, :integer, :default => 0
  end
end
