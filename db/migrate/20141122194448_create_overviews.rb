class CreateOverviews < ActiveRecord::Migration
  def change
    create_table :overviews do |t|
      t.references :profile
      t.text :objective
      t.text :cover_letter

      t.timestamps
    end
  end
end
