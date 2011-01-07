class AddReplyCounterToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :reply_counter, :integer
    add_index :posts, [:topic_id, :reply_counter], :unique => true
  end

  def self.down
    remove_index :posts, [:topic_id, :reply_counter]
    remove_column :posts, :reply_counter
  end
end
