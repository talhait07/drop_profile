class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.float :unit_price
      t.integer :cart_id
      t.integer :quantity
      t.integer :template_id

      t.timestamps
    end
  end
end
