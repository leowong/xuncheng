class AddTypesMaskToCallings < ActiveRecord::Migration
  def self.up
    add_column :callings, :types_mask, :integer
  end

  def self.down
    remove_column :callings, :types_mask
  end
end
