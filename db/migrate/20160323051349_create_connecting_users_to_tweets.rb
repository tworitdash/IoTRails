class CreateConnectingUsersToTweets < ActiveRecord::Migration
  def change
    create_table :connecting_users_to_tweets do |t|
      add_reference :tweets, :user, index: true, foreign_key: true
      #add_foreign_key :tweets, :users
      t.timestamps null: false
    end
  end
end
