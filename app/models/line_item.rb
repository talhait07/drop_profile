# unit_price:float (default: 0.0), cart_id:integer, quantity:integer, template_id:integer, created_at:datetime, updated_at:datetime
class LineItem < ActiveRecord::Base
  # == Associations and Nested Attributes == #
  belongs_to :cart
  belongs_to :template
end
