class CouponsController < InheritedResources::Base

  private

    def coupon_params
      params.require(:coupon).permit(:code, :discount_amount)
    end
end

