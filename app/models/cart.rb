#purchased_at:datetime, created_at:datetime, updated_at:datetime, user_id:integer
class Cart < ActiveRecord::Base
  # == Associations and Nested Attributes == #
  has_many :line_items
  belongs_to :user

  # == Instance Methods == #
  def total_price
    line_items.to_a.sum(&:unit_price)
  end
end
