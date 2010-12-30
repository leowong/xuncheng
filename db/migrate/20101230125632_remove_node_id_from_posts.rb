class RemoveNodeIdFromPosts < ActiveRecord::Migration
  def self.up
    remove_index :posts, :node_id
    remove_column :posts, :node_id
  end

  def self.down
    add_column :posts, :node_id, :integer
    add_index :posts, :node_id
  end
end
