class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string "full_name", :limit => 50
      t.string "username"
      t.string "email"
      t.string "password", :limit => 40
      t.string "salt"
      t.timestamps null: false
    end
  end
end
