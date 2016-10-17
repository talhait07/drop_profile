class CurrentToExperiencesEducations < ActiveRecord::Migration
  def change
    add_column :experiences, :current, :boolean, default: false
    add_column :educations, :current, :boolean, default: false
  end
end
