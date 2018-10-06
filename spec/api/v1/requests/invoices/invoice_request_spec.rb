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

  # relationships:

  it 'responds to /api/v1/invoices/:id/transactions' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    other_invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    other_transactions = create_list(:transaction, 3, invoice_id: other_invoice.id)
    transactions = create_list(:transaction, 5, invoice_id: invoice.id)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    response_transactions = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transactions.length).to eq(5)
    expect(response_transactions.first["invoice_id"]).to eq(invoice.id)
  end

  it 'responds to /api/v1/invoices/:id/invoice_items' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    other_invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    item = create(:item, merchant_id: merchant.id)
    other_invoice_items = create_list(:invoice_item, 3, item_id: item.id, invoice_id: other_invoice.id)
    invoice_items = create_list(:invoice_item, 5, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    response_invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_invoice_items.length).to eq(5)
    expect(response_invoice_items.first["invoice_id"]).to eq(invoice.id)
  end

  it 'responds to /api/v1/invoices/:id/items' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    other_invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    valid_item_1 = create(:item, merchant_id: merchant.id)
    valid_item_2 = create(:item, merchant_id: merchant.id)
    valid_item_3 = create(:item, merchant_id: merchant.id)
    invalid_item = create(:item, merchant_id: merchant.id)
    other_invoice_items = create_list(:invoice_item, 3, item_id: invalid_item.id, invoice_id: other_invoice.id)
    invoice_items_1 = create(:invoice_item, item_id: valid_item_1.id, invoice_id: invoice.id, quantity: 5)
    invoice_items_2 = create(:invoice_item, item_id: valid_item_2.id, invoice_id: invoice.id, quantity: 3)
    invoice_items_3 = create(:invoice_item, item_id: valid_item_3.id, invoice_id: invoice.id, quantity: 2)

    get "/api/v1/invoices/#{invoice.id}/items"

    response_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_items.length).to eq(3)
    expect(response_items[0]["id"]).to eq(valid_item_1.id)
    expect(response_items[1]["id"]).to eq(valid_item_2.id)
    expect(response_items[2]["id"]).to eq(valid_item_3.id)
  end

  it 'responds to /api/v1/invoices/:id/customer' do
    merchant = create(:merchant)
    customer = create(:customer)
    other_customer = create(:customer)
    other_invoice = create(:invoice, merchant_id: merchant.id, customer_id: other_customer.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

    get "/api/v1/invoices/#{invoice.id}/customer"

    response_customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_customer["id"]).to eq(customer.id)
  end

  it 'responds to /api/v1/invoices/:id/merchant' do
    merchant = create(:merchant)
    other_merchant = create(:merchant)
    customer = create(:customer)
    other_invoice = create(:invoice, merchant_id: other_merchant.id, customer_id: customer.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    response_merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_merchant["id"]).to eq(merchant.id)
  end
end
