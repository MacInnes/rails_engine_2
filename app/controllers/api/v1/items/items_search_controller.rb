class Api::V1::Items::ItemsSearchController < ApplicationController

  def show
    render json: Item.find_by(search_params)
  end

  def index
    render json: Item.where(search_params)
  end

  private
  def search_params
    params.permit(:id, :name, :created_at, :updated_at, :description, :unit_price)
  end
end
