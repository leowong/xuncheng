class CreateGroupings < ActiveRecord::Migration
  def self.up
    create_table :groupings do |t|
      t.integer :user_id
      t.integer :node_id

      t.timestamps
    end

    add_index :groupings, :user_id
    add_index :groupings, :node_id
  end

  def self.down
    remove_index :groupings, :node_id
    remove_index :groupings, :user_id

    drop_table :groupings
  end
end
