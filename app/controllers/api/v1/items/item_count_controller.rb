class Api::V1::Items::ItemCountController < ApplicationController

  def index
    render json: Item.most_items(params[:quantity])
  end

end
