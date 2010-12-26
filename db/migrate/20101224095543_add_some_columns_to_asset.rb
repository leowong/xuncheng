class AddSomeColumnsToAsset < ActiveRecord::Migration
  def self.up
    add_column :assets, :type, :string, :limit => 75
    add_column :assets, :attachment_width, :integer
    add_column :assets, :attachment_height, :integer

    remove_index :assets, [:viewable_type, :viewable_id]
    add_index :assets, [:viewable_type, :type, :viewable_id]
  end

  def self.down
    remove_index :assets, [:viewable_type, :type, :viewable_id]
    add_index :assets, [:viewable_type, :viewable_id]

    remove_column :assets, :attachment_height
    remove_column :assets, :attachment_width
    remove_column :assets, :type
  end
end
