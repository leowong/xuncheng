class AddIndexToReplies < ActiveRecord::Migration
  def self.up
    add_index :replies, :topic_id
  end

  def self.down
    remove_index :replies, :topic_id
  end
end
