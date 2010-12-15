class AddNodeIdToTopic < ActiveRecord::Migration
  def self.up
    add_column :topics, :node_id, :integer
    add_index :topics, :node_id
  end

  def self.down
    remove_index :topics, :node_id
    remove_column :topics, :node_id
  end
end
