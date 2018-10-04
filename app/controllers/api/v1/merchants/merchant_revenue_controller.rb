class Api::V1::Merchants::MerchantRevenueController < ApplicationController
  def index
    render json: Merchant.revenue_by_date(params[:date]), serializer: TotalRevenueSerializer
  end
end
