class DropTopics < ActiveRecord::Migration
  def self.up
    remove_index :topics, :node_id
    remove_index :topics, :user_id

    drop_table :topics
  end

  def self.down
    create_table :topics do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :node_id

      t.timestamps
    end

    add_index :topics, :user_id
    add_index :topics, :node_id
  end
end
