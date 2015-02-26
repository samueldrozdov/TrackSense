class AddPopularityAndPublicToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :popularity, :integer, :default => 0
    add_column :groups, :is_public, :integer, :default => 1
  end
end
