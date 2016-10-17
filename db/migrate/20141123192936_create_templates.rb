class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.references :user
      t.string :name
      t.string :style
      t.float :price
      t.string :colors
      t.string :image

      t.timestamps
    end
  end
end
