class AddUserIdToReply < ActiveRecord::Migration
  def self.up
    add_column :replies, :user_id, :integer
    add_index :replies, :user_id
  end

  def self.down
    remove_index :replies, :user_id
    remove_column :replies, :user_id
  end
end
