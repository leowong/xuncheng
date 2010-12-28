class DropReplies < ActiveRecord::Migration
  def self.up
    remove_index :replies, :user_id
    remove_index :replies, :topic_id

    drop_table :replies
  end

  def self.down
    create_table :replies do |t|
      t.text :content
      t.references :topic
      t.integer :user_id

      t.timestamps
    end

    add_index :replies, :topic_id
    add_index :replies, :user_id
  end
end
