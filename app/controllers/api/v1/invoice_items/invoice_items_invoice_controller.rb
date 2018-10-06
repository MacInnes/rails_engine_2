class Api::V1::InvoiceItems::InvoiceItemsInvoiceController < ApplicationController

  def show
    render json: InvoiceItem.find(params[:invoice_item_id]).invoice
  end

end
