class CreateAlterUsers < ActiveRecord::Migration
  def change
    create_table :alter_users do |t|
      rename_column("users", "password", "hashed_password")
      t.timestamps null: false
    end
  end
end
