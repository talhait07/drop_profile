class LineItemsController < ApplicationController
  def create
    #raise current_cart.inspect
    @template = Template.find(params[:template_id])
    @exist = false
    if LineItem.exists?(cart_id: current_cart.id, template_id: @template.id)
      @exist = true
      flash[:warn] = 'The template is already added.'
    else
      @line_item = LineItem.create!(cart: current_cart, template: @template, quantity: 1, unit_price: @template.price)
      flash[:notice] = "Added #{@template.name} to cart."
    end
    @total_count = current_cart.line_items.count

    #After payment completed successfully we need to redirect to add_to_my_template_path immediately
    #redirect_to add_to_my_template_path(@template.id, color: @template.color_codes.join(','))
  end

  private
  def line_item_params
    params.require(:line_item).permit(:unit_price, :cart_id, :quantity, :template_id)
  end
end

