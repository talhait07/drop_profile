class CreateAdvertisementCountries < ActiveRecord::Migration
  def change
    create_table :advertisements_countries do |t|
      t.references :advertisement, null: false
      t.references :country, null: false

      t.timestamps
    end
  end
end
