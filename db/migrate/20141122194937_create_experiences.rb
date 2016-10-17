class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.references :profile
      t.string :title
      t.string :company
      t.string :location
      t.string :designation
      t.text :description
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
