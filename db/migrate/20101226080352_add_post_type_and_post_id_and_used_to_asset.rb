class AddPostTypeAndPostIdAndUsedToAsset < ActiveRecord::Migration
  def self.up
    add_column :assets, :post_type, :string, :limit => 50
    add_column :assets, :post_id, :integer
    add_column :assets, :used, :boolean
  end

  def self.down
    remove_column :assets, :used
    remove_column :assets, :post_id
    remove_column :assets, :post_type
  end
end
