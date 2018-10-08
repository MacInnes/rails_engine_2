class Api::V1::Merchants::MerchantPendingController < ApplicationController

  def index
    render json: Merchant.find(params[:merchant_id]).pending_invoices
  end

end
