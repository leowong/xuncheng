class AddUsernameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :username, :string, :default => "", :null => false
    add_index :users, :username, :unique => true
  end

  def self.down
    remove_index :users, :username
    remove_column :users, :username
  end
end
