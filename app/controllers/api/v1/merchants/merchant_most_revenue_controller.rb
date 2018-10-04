class Api::V1::Merchants::MerchantMostRevenueController < ApplicationController

  def index
    render json: Merchant.most_revenue(params[:quantity].to_i)
  end

end
