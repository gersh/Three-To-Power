class AddFollowingToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :follow_uid, :string
    add_column :users, :follow_name, :string
  end

  def self.down
    remove_column :users, :follow_name
    remove_column :users, :follow_uid
  end
end
