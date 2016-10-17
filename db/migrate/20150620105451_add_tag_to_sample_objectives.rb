class AddTagToSampleObjectives < ActiveRecord::Migration
  def change
    add_column :sample_objectives, :tags, :string, :limit => 70, array: true, default: []
  end
end
