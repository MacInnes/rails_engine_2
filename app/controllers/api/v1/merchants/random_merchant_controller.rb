class Api::V1::Merchants::RandomMerchantController < ApplicationController
  def show
    render json: Merchant.order(Arel.sql('RANDOM()')).first
  end
end
