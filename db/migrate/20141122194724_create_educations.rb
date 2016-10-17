class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.references :profile
      t.string :title
      t.string :institute
      t.string :location
      t.string :major
      t.string :result
      t.text :description
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
