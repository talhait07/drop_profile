class AddActivateInfoToUserTemplate < ActiveRecord::Migration
  def change
    add_column :user_templates, :last_activated_at, :datetime, default: '2015-01-01 00:00:00'
    add_column :user_templates, :active_count, :integer, default: 0
    rename_column :user_templates, :current, :active
  end
end
