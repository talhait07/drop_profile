class CartsController < InheritedResources::Base
  def destroy
    cart = Cart.find params[:id]
    cart.line_items.destroy_all
    redirect_to templates_url
  end

  private
  def cart_params
    params.require(:cart).permit(:purchased_at)
  end
end

