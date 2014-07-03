class RevampNotifications < ActiveRecord::Migration
  def change
    drop_table :notifications

    create_table :actions do |t|
      t.integer     :user_id
      t.integer     :action_type
      t.integer     :actionable_id
      t.string      :actionable_type
      t.text        :data

      t.timestamps
    end

    create_table :notifications do |t|
      t.belongs_to :user
      t.belongs_to :group
      t.belongs_to :organization
      t.belongs_to :conversation
      t.belongs_to :action

      t.timestamps
    end
  end
end
