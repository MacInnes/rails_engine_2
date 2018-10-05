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

  it 'responds to /api/v1/invoices/find?id=x' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)


    get "/api/v1/invoices/find?id=#{invoice.id}"

    response_invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice["id"]).to eq(invoice.id)
  end

  it 'responds to /api/v1/invoices/find?customer_id=x' do
    customer = create(:customer)
    wrong_customer = create(:customer)
    merchant = create(:merchant)
    invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: wrong_customer.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)


    get "/api/v1/invoices/find?customer_id=#{invoice.customer_id}"

    response_invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice["id"]).to eq(invoice.id)
  end

  it 'responds to /api/v1/invoices/find?merchant_id=x' do
    customer = create(:customer)
    merchant = create(:merchant)
    wrong_merchant = create(:merchant)
    invoices = create_list(:invoice, 3, merchant_id: wrong_merchant.id, customer_id: customer.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)


    get "/api/v1/invoices/find?merchant_id=#{invoice.merchant_id}"

    response_invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice["id"]).to eq(invoice.id)
  end

  it 'responds to /api/v1/invoices/find?status=x' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id, status: 'iuegriuwfiu')
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)


    get "/api/v1/invoices/find?status=#{invoice.status}"

    response_invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice["id"]).to eq(invoice.id)
  end

  it 'responds to /api/v1/invoices/find?created_at=123' do
    date = "2012-03-09T08:57:21.000Z"
    customer = create(:customer)
    merchant = create(:merchant)
    invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, created_at: date)

    get "/api/v1/invoices/find?created_at=#{date}"
    response_invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice["id"]).to eq(invoice.id)
  end

  it 'responds to /api/v1/invoices/find?updated_at=123' do
    date = "2012-03-09T08:57:21.000Z"
    customer = create(:customer)
    merchant = create(:merchant)
    invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, updated_at: date)

    get "/api/v1/invoices/find?updated_at=#{date}"
    response_invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice["id"]).to eq(invoice.id)
  end

  it 'responds to /api/v1/invoices/find_all?id=x' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)


    get "/api/v1/invoices/find_all?id=#{invoice.id}"

    response_invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice.first["id"]).to eq(invoice.id)
  end

  it 'responds to /api/v1/invoices/find_all?customer_id=x' do
    customer = create(:customer)
    wrong_customer = create(:customer)
    merchant = create(:merchant)
    invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: wrong_customer.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)


    get "/api/v1/invoices/find_all?customer_id=#{invoice.customer_id}"

    response_invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice.first["id"]).to eq(invoice.id)
  end

  it 'responds to /api/v1/invoices/find_all?merchant_id=x' do
    customer = create(:customer)
    merchant = create(:merchant)
    wrong_merchant = create(:merchant)
    invoices = create_list(:invoice, 3, merchant_id: wrong_merchant.id, customer_id: customer.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)


    get "/api/v1/invoices/find_all?merchant_id=#{invoice.merchant_id}"

    response_invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice.first["id"]).to eq(invoice.id)
  end

  it 'responds to /api/v1/invoices/find_all?status=x' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id, status: 'iuegriuwfiu')
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)


    get "/api/v1/invoices/find_all?status=#{invoice.status}"

    response_invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice.first["id"]).to eq(invoice.id)
  end

  it 'responds to /api/v1/invoices/find_all?created_at=123' do
    date = "2012-03-09T08:57:21.000Z"
    customer = create(:customer)
    merchant = create(:merchant)
    invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, created_at: date)

    get "/api/v1/invoices/find_all?created_at=#{date}"
    response_invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice.first["id"]).to eq(invoice.id)
  end

  it 'responds to /api/v1/invoices/find_all?updated_at=123' do
    date = "2012-03-09T08:57:21.000Z"
    customer = create(:customer)
    merchant = create(:merchant)
    invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, updated_at: date)

    get "/api/v1/invoices/find_all?updated_at=#{date}"
    response_invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice.first["id"]).to eq(invoice.id)
  end
end
