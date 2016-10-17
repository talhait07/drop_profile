class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :code
      t.float :discount_amount

      t.timestamps
    end
  end
end
