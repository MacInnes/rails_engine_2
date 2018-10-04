class Api::V1::Merchants::SingleMerchantRevenueController < ApplicationController

  def show
    merchant = Merchant.find(params[:merchant_id])
    render json: merchant.revenue, serializer: RevenueSerializer
  end
end
