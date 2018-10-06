class Api::V1::Merchants::MerchantInvoicesController < ApplicationController

  def index
    render json: Merchant.find(params["merchant_id"]).invoices
  end

end
