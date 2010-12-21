class AddSomeColumnsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :signature, :string
    add_column :users, :biography, :text
    add_column :users, :email_publishing, :boolean, :default => false

    User.reset_column_information
    User.all.each do |u|
      u.update_attribute(:email_publishing, false)
    end
  end

  def self.down
    remove_column :users, :email_publishing
    remove_column :users, :biography
    remove_column :users, :signature
  end
end
