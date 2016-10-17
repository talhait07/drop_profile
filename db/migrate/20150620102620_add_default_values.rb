class AddDefaultValues < ActiveRecord::Migration
  def up
    change_column_default :templates, :price, 0
    change_column_default :line_items, :unit_price, 0
    change_column_default :coupons, :discount_amount, 0
  end

  def down
    change_column_default :templates, :price, nil
    change_column_default :line_items, :unit_price, nil
    change_column_default :coupons, :discount_amount, nil
  end
end
