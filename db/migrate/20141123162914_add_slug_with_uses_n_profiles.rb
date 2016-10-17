class AddSlugWithUsesNProfiles < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string
    add_index :users, :slug

    add_column :profiles, :slug, :string
    add_index :profiles, :slug
  end
end
