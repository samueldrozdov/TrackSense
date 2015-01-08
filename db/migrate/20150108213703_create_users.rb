class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password_digest
      t.float :reputation
      t.boolean :is_admin

      t.timestamps null: false
    end
  end
end
