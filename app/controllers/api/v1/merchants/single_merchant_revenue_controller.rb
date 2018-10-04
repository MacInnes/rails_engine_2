class Api::V1::Merchants::SingleMerchantRevenueController < ApplicationController

  def show
    merchant = Merchant.find(params[:merchant_id])
    if (params[:date])
      render json: merchant.revenue_by_date(params[:date]), serializer: RevenueSerializer
    else
      render json: merchant.revenue, serializer: RevenueSerializer
    end
  end
end
