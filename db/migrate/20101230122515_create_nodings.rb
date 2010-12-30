class CreateNodings < ActiveRecord::Migration
  def self.up
    create_table :nodings do |t|
      t.integer :node_id
      t.integer :topic_id

      t.timestamps
    end

    add_index :nodings, :node_id
    add_index :nodings, :topic_id
  end

  def self.down
    remove_index :nodings, :topic_id
    remove_index :nodings, :node_id

    drop_table :nodings
  end
end
