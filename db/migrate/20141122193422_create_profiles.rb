class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :title
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :phone
      t.string :status
      t.string :web_link
      t.string :facebook_link
      t.string :twitter_link
      t.string :linkedin_link
      t.string :google_plus_link

      t.timestamps
    end
  end
end
