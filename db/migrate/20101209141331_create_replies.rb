class CreateReplies < ActiveRecord::Migration
  def self.up
    create_table :replies do |t|
      t.text :content
      t.references :topic

      t.timestamps
    end
  end

  def self.down
    drop_table :replies
  end
end
