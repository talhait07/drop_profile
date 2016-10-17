class AddDefaultSiteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :default_site, :string, default: 'dropresume.com'
  end
end
