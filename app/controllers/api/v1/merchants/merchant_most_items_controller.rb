class Api::V1::Merchants::MerchantMostItemsController < ApplicationController
  def index
    render json: Merchant.most_items_sold(params[:quantity].to_i)
  end
end
