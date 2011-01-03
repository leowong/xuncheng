class CreateCallings < ActiveRecord::Migration
  def self.up
    create_table :callings do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end

    add_index :callings, :user_id
  end

  def self.down
    remove_index :callings, :user_id

    drop_table :callings
  end
end
