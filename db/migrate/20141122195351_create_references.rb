class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.references :profile
      t.string :name
      t.string :designation
      t.string :company
      t.string :location
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
