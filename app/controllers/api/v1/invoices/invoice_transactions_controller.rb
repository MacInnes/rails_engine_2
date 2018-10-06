class Api::V1::Invoices::InvoiceTransactionsController < ApplicationController

  def index
    render json: Invoice.find(params[:invoice_id]).transactions
  end

end
