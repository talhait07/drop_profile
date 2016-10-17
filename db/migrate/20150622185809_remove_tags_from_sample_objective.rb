class RemoveTagsFromSampleObjective < ActiveRecord::Migration
  def change
    remove_column :sample_objectives, :tags
  end
end
