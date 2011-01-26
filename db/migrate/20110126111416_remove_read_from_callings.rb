class RemoveReadFromCallings < ActiveRecord::Migration
  def self.up
    remove_column :callings, :read

    add_index :callings, :post_id
  end

  def self.down
    remove_index :callings, :post_id

    add_column :callings, :read, :boolean
  end
end
