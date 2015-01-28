class CreateTagRelationships < ActiveRecord::Migration
  def change
    create_table :tag_relationships do |t|
      t.integer :tag_id
      t.integer :tagged_id

      t.timestamps null: false
    end

    add_index :tag_relationships, :tag_id
    add_index :tag_relationships, :tagged_id
    add_index :tag_relationships, [:tag_id, :tagged_id], unique: true
  end
end
