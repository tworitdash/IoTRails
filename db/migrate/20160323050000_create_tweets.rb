class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string 'tweet', :limit => 140
      
      t.timestamps null: false
    end
  end
end
