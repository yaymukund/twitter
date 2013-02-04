class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :content
      t.references :user

      t.timestamps
    end
    add_index :tweets, :user_id
  end
end
