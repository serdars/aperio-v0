class AddOrganizationSummary < ActiveRecord::Migration
  def change
    add_column :organizations, :summary, :text, :limit => 255
  end
end
