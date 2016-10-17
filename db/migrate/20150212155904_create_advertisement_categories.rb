class CreateAdvertisementCategories < ActiveRecord::Migration
  def change
    create_table :advertisements_categories do |t|
      t.references :advertisement, null: false
      t.references :category, null: false

      t.timestamps
    end
  end
end
