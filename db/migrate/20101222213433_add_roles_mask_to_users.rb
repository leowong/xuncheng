class AddRolesMaskToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :roles_mask, :integer

    User.reset_column_information
    users_count = User.count
    if users_count > 0
      u = User.first
      u.roles = %w[admin moderator author]
      u.save
    end
    if users_count > 1
      User.all[1..-1].each do |u|
        u.roles = %w[author]
        u.save
      end
    end
  end

  def self.down
    remove_column :users, :roles_mask
  end
end
