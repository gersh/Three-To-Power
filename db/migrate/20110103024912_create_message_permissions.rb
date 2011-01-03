class CreateMessagePermissions < ActiveRecord::Migration
  def self.up
    create_table :message_permissions do |t|
      t.references :message
      t.string :uid

      t.timestamps
    end
  end

  def self.down
    drop_table :message_permissions
  end
end
