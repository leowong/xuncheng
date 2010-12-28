class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :node_id
      t.integer :topic_id
      t.string :type

      t.timestamps
    end

    add_index :posts, :user_id
    add_index :posts, :node_id
    add_index :posts, :topic_id
    add_index :posts, :type
  end

  def self.down
    remove_index :posts, :type
    remove_index :posts, :topic_id
    remove_index :posts, :node_id
    remove_index :posts, :user_id

    drop_table :posts
  end
end
