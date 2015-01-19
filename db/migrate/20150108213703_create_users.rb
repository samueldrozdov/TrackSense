class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password_digest
      t.float :reputation, default: 0
      t.boolean :is_admin, default: false

      t.timestamps null: false
    end
  end
end
