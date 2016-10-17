class AddColorToUserTemplate < ActiveRecord::Migration
  def change
    add_column :user_templates, :color, :string
  end
end
