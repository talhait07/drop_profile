class CreateAdminContact < ActiveRecord::Migration
  def change
    create_table :admin_contacts do |t|
      t.string :name
      t.string :email
      t.string :category
      t.string :title
      t.text :body
    end
    add_index :admin_contacts, :category
  end
end
