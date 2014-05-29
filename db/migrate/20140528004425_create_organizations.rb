class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name,        :null => false
      t.text   :description, :null => false
      t.string :website,     :null => false

      t.timestamps
    end
  end
end
