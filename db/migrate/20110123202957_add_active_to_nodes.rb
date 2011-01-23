class AddActiveToNodes < ActiveRecord::Migration
  def self.up
    add_column :nodes, :active, :boolean
  end

  def self.down
    remove_column :nodes, :active
  end
end
