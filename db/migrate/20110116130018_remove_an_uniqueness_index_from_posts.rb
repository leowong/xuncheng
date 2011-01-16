class RemoveAnUniquenessIndexFromPosts < ActiveRecord::Migration
  def self.up
    remove_index :posts, [:topic_id, :reply_counter]
    add_index :posts, [:topic_id, :reply_counter]
  end

  def self.down
    remove_index :posts, [:topic_id, :reply_counter]
    add_index :posts, [:topic_id, :reply_counter], :unique => true
  end
end
