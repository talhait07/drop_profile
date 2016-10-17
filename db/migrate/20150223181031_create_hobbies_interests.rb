class CreateHobbiesInterests < ActiveRecord::Migration
  def change
    create_table :hobbies_interests do |t|
      t.references :user, index: true
      t.string :title

      t.timestamps
    end
  end
end
