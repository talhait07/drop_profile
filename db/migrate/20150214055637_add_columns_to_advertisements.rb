class AddColumnsToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :all_country, :boolean, default: false
    add_column :advertisements, :all_category, :boolean, default: false
  end
end
