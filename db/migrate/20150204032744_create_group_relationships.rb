class CreateGroupRelationships < ActiveRecord::Migration
  def change
    create_table :group_relationships do |t|
      t.integer :group_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :group_relationships, :group_id
    add_index :group_relationships, :user_id
    add_index :group_relationships, [:group_id, :user_id], unique: true
  end
end
