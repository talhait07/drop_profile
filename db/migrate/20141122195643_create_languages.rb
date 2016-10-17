class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.references :profile
      t.string :name
      t.integer :reading_level
      t.integer :writing_level
      t.integer :speaking_level

      t.timestamps
    end
  end
end
