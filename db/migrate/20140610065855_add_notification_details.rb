class AddNotificationDetails < ActiveRecord::Migration
  def change
    add_column :notifications, :organization_id, :integer
  end
end
