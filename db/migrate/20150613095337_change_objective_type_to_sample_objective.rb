class ChangeObjectiveTypeToSampleObjective < ActiveRecord::Migration
  def change
    change_column :sample_objectives, :objective, :text
  end
end
