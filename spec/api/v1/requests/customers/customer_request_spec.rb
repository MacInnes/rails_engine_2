require 'rails_helper'

describe 'Customer endpoints' do
  it 'responds to /api/v1/customers' do
    create_list(:customer, 4)

    get '/api/v1/customers'

    response_customers = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customers.length).to eq(4)
  end

  it 'responds to /api/v1/customers/:id' do
    create_list(:customer, 4)
    target = create(:customer)

    get "/api/v1/customers/#{target.id}"

    response_customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customer["id"]).to eq(target.id)
  end

  it 'responds to /api/v1/customers/find?id=x' do
    create_list(:customer, 4)
    target = create(:customer)

    get "/api/v1/customers/find?id=#{target.id}"

    response_customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_customer["id"]).to eq(target.id)
  end

  it 'responds to /api/v1/customers/find?first_name=asdf' do
    create_list(:customer, 4)
    target = create(:customer, first_name: "asdf")

    get "/api/v1/customers/find?first_name=#{target.first_name}"

    response_customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_customer["id"]).to eq(target.id)
  end

  it 'responds to /api/v1/customers/find?last_name=asdf' do
    create_list(:customer, 4)
    target = create(:customer, last_name: "asdf")

    get "/api/v1/customers/find?last_name=#{target.last_name}"

    response_customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_customer["id"]).to eq(target.id)
  end

  it 'responds to /api/v1/customers/find?created_at=2012-03-27T14:56:04.000Z' do
    create_list(:customer, 4)
    target = create(:customer, created_at: "2012-03-27T14:56:04.000Z")

    get "/api/v1/customers/find?created_at=2012-03-27T14:56:04.000Z"

    response_customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_customer["id"]).to eq(target.id)
  end

  it 'responds to /api/v1/customers/find?updated_at=2012-03-27T14:56:04.000Z' do
    create_list(:customer, 4)
    target = create(:customer, updated_at: "2012-03-27T14:56:04.000Z")

    get "/api/v1/customers/find?updated_at=2012-03-27T14:56:04.000Z"

    response_customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_customer["id"]).to eq(target.id)
  end

  #find all

  it 'responds to /api/v1/customers/find_all?id=x' do
    create_list(:customer, 4)
    target = create(:customer)

    get "/api/v1/customers/find_all?id=#{target.id}"

    response_customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_customer.first["id"]).to eq(target.id)
  end

  it 'responds to /api/v1/customers/find_all?first_name=asdf' do
    create_list(:customer, 4)
    create_list(:customer, 3, first_name: "asdf")

    get "/api/v1/customers/find_all?first_name=asdf"

    response_customers = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_customers.length).to eq(3)
  end

  it 'responds to /api/v1/customers/find_all?last_name=asdf' do
    create_list(:customer, 4)
    create_list(:customer, 3, last_name: "asdf")

    get "/api/v1/customers/find_all?last_name=asdf"

    response_customers = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_customers.length).to eq(3)
  end

  it 'responds to /api/v1/customers/find_all?created_at=2012-03-27T14:56:04.000Z' do
    create_list(:customer, 4)
    create_list(:customer, 3, created_at: "2012-03-27T14:56:04.000Z")

    get "/api/v1/customers/find_all?created_at=2012-03-27T14:56:04.000Z"

    response_customers = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_customers.length).to eq(3)

  end

  it 'responds to /api/v1/customers/find_all?updated_at=2012-03-27T14:56:04.000Z' do
    create_list(:customer, 4)
    create_list(:customer, 3, updated_at: "2012-03-27T14:56:04.000Z")

    get "/api/v1/customers/find_all?updated_at=2012-03-27T14:56:04.000Z"

    response_customers = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_customers.length).to eq(3)
  end

  # relationships

  it 'responds to /api/v1/customers/:id/invoices' do
    customer = create(:customer)
    other_customer = create(:customer)
    merchant = create(:merchant)
    invoices = create_list(:invoice, 5, merchant_id: merchant.id, customer_id: customer.id)
    other_invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: other_customer.id)

    get "/api/v1/customers/#{customer.id}/invoices"

    response_invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_invoices.length).to eq(5)
    expect(response_invoices.first["customer_id"]).to eq(customer.id)
  end

  it 'responds to /api/v1/customers/:id/transactions' do
    customer = create(:customer)
    other_customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    other_invoice = create(:invoice, merchant_id: merchant.id, customer_id: other_customer.id)
    transactions = create_list(:transaction, 5, invoice_id: invoice.id)
    other_transactions = create_list(:transaction, 3, invoice_id: other_invoice.id)

    get "/api/v1/customers/#{customer.id}/transactions"

    response_transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_transactions.first["invoice_id"]).to eq(invoice.id)

  end

end
