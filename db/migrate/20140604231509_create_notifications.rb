class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :user
      t.integer  :subject_id
      t.string   :action
      t.integer  :notifiable_id
      t.string   :notifiable_type

      t.timestamps
    end
  end
end
