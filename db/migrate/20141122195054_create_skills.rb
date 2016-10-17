class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.references :profile
      t.string :name
      t.integer :level
      t.boolean :match

      t.timestamps
    end
  end
end
