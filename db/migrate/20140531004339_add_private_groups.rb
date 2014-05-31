class AddPrivateGroups < ActiveRecord::Migration
  def change
    add_column :groups, :visible, :boolean, default: true
    add_column :groups, :private, :boolean, default: false
  end
end
