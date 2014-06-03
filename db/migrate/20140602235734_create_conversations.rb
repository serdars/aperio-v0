class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.string     :title,     :null => false
      t.belongs_to :group
      t.belongs_to :user

      t.timestamps
    end
  end
end
