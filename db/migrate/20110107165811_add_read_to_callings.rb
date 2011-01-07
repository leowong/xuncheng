class AddReadToCallings < ActiveRecord::Migration
  def self.up
    add_column :callings, :read, :boolean
  end

  def self.down
    remove_column :callings, :read
  end
end
