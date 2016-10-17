class AddColumnsToTemplates < ActiveRecord::Migration
  def change
    add_column :templates, :uploaded_file, :string
    add_column :templates, :formatted_file, :string
    add_column :templates, :is_approved, :boolean, default: false
    add_column :templates, :is_published, :boolean, default: false
    add_column :templates, :status, :string, default: 'new'
  end
end
