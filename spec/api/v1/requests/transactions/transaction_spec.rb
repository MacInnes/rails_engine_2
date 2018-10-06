require 'rails_helper'

describe 'Transaction endpoints' do
  it 'responds to /api/v1/transactions' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transactions = create_list(:transaction, 5, invoice_id: invoice.id)

    get '/api/v1/transactions'

    response_transactions = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transactions.length).to eq(5)
  end

  it 'responds to /api/v1/transactions/:id' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction = create(:transaction, invoice_id: invoice.id)
    other_transaction = create(:transaction, invoice_id: invoice.id)

    get "/api/v1/transactions/#{transaction.id}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction["id"]).to eq(transaction.id)
  end

  # single-finders:

  it 'responds to /api/v1/transactions/find?id=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    other_transaction = create(:transaction, invoice_id: invoice.id)
    transaction = create(:transaction, invoice_id: invoice.id)

    get "/api/v1/transactions/find?id=#{transaction.id}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction["id"]).to eq(transaction.id)
  end

  it 'responds to /api/v1/transactions/find?invoice_id=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    other_invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    other_transaction = create(:transaction, invoice_id: other_invoice.id)
    transaction = create(:transaction, invoice_id: invoice.id)

    get "/api/v1/transactions/find?invoice_id=#{transaction.invoice_id}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction["id"]).to eq(transaction.id)
  end

  it 'responds to /api/v1/transactions/find?credit_card_number=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    other_invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    other_transaction = create(:transaction, invoice_id: other_invoice.id)
    transaction = create(:transaction, invoice_id: invoice.id, credit_card_number: "4367385045579566")

    get "/api/v1/transactions/find?credit_card_number=#{transaction.credit_card_number}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction["id"]).to eq(transaction.id)
  end

  it 'responds to /api/v1/transactions/find?result=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    other_invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    other_transaction = create(:transaction, invoice_id: other_invoice.id)
    transaction = create(:transaction, invoice_id: invoice.id, result: "success")

    get "/api/v1/transactions/find?result=#{transaction.result}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction["id"]).to eq(transaction.id)
  end

  it 'responds to /api/v1/transactions/find?created_at=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    other_invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    other_transaction = create(:transaction, invoice_id: other_invoice.id)
    transaction = create(:transaction, invoice_id: invoice.id, created_at: "2012-03-27T14:56:42.000Z")

    get "/api/v1/transactions/find?created_at=#{transaction.created_at}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction["id"]).to eq(transaction.id)
  end

  it 'responds to /api/v1/transactions/find?updated_at=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    other_invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    other_transaction = create(:transaction, invoice_id: other_invoice.id)
    transaction = create(:transaction, invoice_id: invoice.id, updated_at: "2012-03-27T14:56:42.000Z")

    get "/api/v1/transactions/find?updated_at=#{transaction.updated_at}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction["id"]).to eq(transaction.id)
  end

  #multi-finders:

  it 'responds to /api/v1/transactions/find_all?id=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    other_transaction = create(:transaction, invoice_id: invoice.id)
    transaction = create(:transaction, invoice_id: invoice.id)

    get "/api/v1/transactions/find_all?id=#{transaction.id}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction.first["id"]).to eq(transaction.id)
  end

  it 'responds to /api/v1/transactions/find_all?invoice_id=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    other_invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    other_transaction = create(:transaction, invoice_id: other_invoice.id)
    transaction = create(:transaction, invoice_id: invoice.id)

    get "/api/v1/transactions/find_all?invoice_id=#{transaction.invoice_id}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction.first["id"]).to eq(transaction.id)
  end

  it 'responds to /api/v1/transactions/find_all?credit_card_number=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    other_invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    other_transaction = create(:transaction, invoice_id: other_invoice.id)
    transaction = create(:transaction, invoice_id: invoice.id, credit_card_number: "4367385045579566")

    get "/api/v1/transactions/find_all?credit_card_number=#{transaction.credit_card_number}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction.first["id"]).to eq(transaction.id)
  end

  it 'responds to /api/v1/transactions/find_all?result=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    other_invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    other_transaction = create(:transaction, invoice_id: other_invoice.id)
    transaction = create(:transaction, invoice_id: invoice.id, result: "success")

    get "/api/v1/transactions/find_all?result=#{transaction.result}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction.first["id"]).to eq(transaction.id)
  end

  it 'responds to /api/v1/transactions/find_all?created_at=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    other_invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    other_transaction = create(:transaction, invoice_id: other_invoice.id)
    transaction = create(:transaction, invoice_id: invoice.id, created_at: "2012-03-27T14:56:42.000Z")

    get "/api/v1/transactions/find_all?created_at=#{transaction.created_at}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction.first["id"]).to eq(transaction.id)
  end

  it 'responds to /api/v1/transactions/find_all?updated_at=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    other_invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    other_transaction = create(:transaction, invoice_id: other_invoice.id)
    transaction = create(:transaction, invoice_id: invoice.id, updated_at: "2012-03-27T14:56:42.000Z")

    get "/api/v1/transactions/find_all?updated_at=#{transaction.updated_at}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction.first["id"]).to eq(transaction.id)
  end
end
