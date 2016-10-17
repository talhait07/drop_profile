class AddSlugToTemplates < ActiveRecord::Migration
  def change
    add_column :templates, :slug, :string
    add_index :templates, :slug
  end
end
