class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.string :title, null: false
      t.string :image
      t.string :url
      t.string :third_party_name
      t.text :third_party_code

      t.timestamps
    end
  end
end
