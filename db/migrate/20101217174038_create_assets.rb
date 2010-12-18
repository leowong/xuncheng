class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.integer :viewable_id
      t.string :viewable_type, :limit => 50
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.integer :attachment_file_size
      t.datetime :attachment_updated_at

      t.timestamps
    end

    add_index :assets, [:viewable_type, :viewable_id]
  end

  def self.down
    remove_index :assets, [:viewable_type, :viewable_id]

    drop_table :assets
  end
end
