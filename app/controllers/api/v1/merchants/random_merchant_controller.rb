class Api::V1::Merchants::RandomMerchantController < ApplicationController
  def show
    render json: Merchant.find(Merchant.pluck(:id).sample)
  end
end
