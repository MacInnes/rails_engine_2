class Api::V1::Merchants::MerchantSearchController < ApplicationController

  def show
    render json: Merchant.order(:id).find_by(search_params)
  end

  def index
    render json: Merchant.where(search_params)
  end

  private

  def search_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
