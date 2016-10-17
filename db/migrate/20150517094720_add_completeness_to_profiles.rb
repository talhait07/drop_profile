class AddCompletenessToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :completeness, :integer, default: 0
  end
end
