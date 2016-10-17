class CreateSampleObjectives < ActiveRecord::Migration
  def change
    create_table :sample_objectives do |t|
      t.string :objective
      t.integer :user_id

      t.timestamps
    end
  end
end
