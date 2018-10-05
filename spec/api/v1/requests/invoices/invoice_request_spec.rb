require 'rails_helper'

describe 'Invoices endpoints' do
  it 'responds to /api/v1/invoices' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id)

    get "/api/v1/invoices"

    response_invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_invoices.length).to eq(3)
  end

  it 'responds to /api/v1/invoices/:id' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id)

    get "/api/v1/invoices/#{invoice.id}"

    response_invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice["id"]).to eq(invoice.id)
  end
end
