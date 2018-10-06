require 'rails_helper'

describe 'Invoice items endpoints' do
  it 'responds to /api/v1/invoice_items' do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items"

    response_invoice_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice_items.length).to eq(3)
  end

  it 'responds to /api/v1/invoice_items/:id' do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    target = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)
    create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/#{target.id}"

    response_invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice_item["id"]).to eq(target.id)
  end

  it 'responds to /api/v1/invoice_items/find?id=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    target = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)
    create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/find?id=#{target.id}"

    response_invoice_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice_items["id"]).to eq(target.id)
  end

  it 'responds to /api/v1/invoice_items/find?item_id=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    other_invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    item = create(:item, merchant_id: merchant.id)
    other_item = create(:item, merchant_id: merchant.id, id: 3)
    create_list(:invoice_item, 3, item_id: other_item.id, invoice_id: other_invoice.id)
    target = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/find?item_id=#{item.id}"

    response_inv_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_inv_item["id"]).to eq(target.id)
  end

  it 'responds to /api/v1/invoice_items/find?invoice_id=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    other_invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    item = create(:item, merchant_id: merchant.id)
    other_item = create(:item, merchant_id: merchant.id, id: 3)
    create_list(:invoice_item, 3, item_id: other_item.id, invoice_id: other_invoice.id)
    target = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/find?invoice_id=#{invoice.id}"

    response_inv_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_inv_item["id"]).to eq(target.id)
  end

  it 'responds to /api/v1/invoice_items/find?quantity=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    other_invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    item = create(:item, merchant_id: merchant.id)
    other_item = create(:item, merchant_id: merchant.id, id: 3)
    create_list(:invoice_item, 3, item_id: other_item.id, invoice_id: other_invoice.id, quantity: 1)
    target = create(:invoice_item, item_id: item.id, invoice_id: invoice.id, quantity: 4)

    get "/api/v1/invoice_items/find?quantity=#{target.quantity}"

    response_inv_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_inv_item["id"]).to eq(target.id)
  end

  it 'responds to /api/v1/invoice_items/find?unit_price=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    other_invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    item = create(:item, merchant_id: merchant.id)
    other_item = create(:item, merchant_id: merchant.id, id: 3)
    create_list(:invoice_item, 3, item_id: other_item.id, invoice_id: other_invoice.id, unit_price: 12345)
    target = create(:invoice_item, item_id: item.id, invoice_id: invoice.id, unit_price: 98765)

    get "/api/v1/invoice_items/find?unit_price=987.65"

    response_inv_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_inv_item["id"]).to eq(target.id)
  end

  it 'responds to /api/v1/invoice_items/find?created_at=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    other_invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    item = create(:item, merchant_id: merchant.id)
    other_item = create(:item, merchant_id: merchant.id, id: 3)
    create_list(:invoice_item, 3, item_id: other_item.id, invoice_id: other_invoice.id)
    target = create(:invoice_item, item_id: item.id, invoice_id: invoice.id, created_at: "2012-03-27T14:57:57.000Z")

    get "/api/v1/invoice_items/find?created_at=#{target.created_at}"

    response_inv_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_inv_item["id"]).to eq(target.id)
  end

  it 'responds to /api/v1/invoice_items/find?updated_at=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    other_invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    item = create(:item, merchant_id: merchant.id)
    other_item = create(:item, merchant_id: merchant.id, id: 3)
    create_list(:invoice_item, 3, item_id: other_item.id, invoice_id: other_invoice.id)
    target = create(:invoice_item, item_id: item.id, invoice_id: invoice.id, updated_at: "2012-03-27T14:57:57.000Z")

    get "/api/v1/invoice_items/find?updated_at=#{target.updated_at}"

    response_inv_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_inv_item["id"]).to eq(target.id)
  end

  # multi-finders:
  it 'responds to /api/v1/invoice_items/find_all?id=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    target = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)
    create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/find_all?id=#{target.id}"

    response_invoice_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice_items.first["id"]).to eq(target.id)
  end

  it 'responds to /api/v1/invoice_items/find_all?item_id=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    other_invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    item = create(:item, merchant_id: merchant.id)
    other_item = create(:item, merchant_id: merchant.id, id: 3)
    create_list(:invoice_item, 3, item_id: other_item.id, invoice_id: other_invoice.id)
    target = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/find_all?item_id=#{item.id}"

    response_invoice_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice_items.first["id"]).to eq(target.id)
  end

  it 'responds to /api/v1/invoice_items/find_all?invoice_id=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    other_invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    item = create(:item, merchant_id: merchant.id)
    other_item = create(:item, merchant_id: merchant.id, id: 3)
    create_list(:invoice_item, 3, item_id: other_item.id, invoice_id: other_invoice.id)
    target = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/find_all?invoice_id=#{invoice.id}"

    response_invoice_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice_items.first["id"]).to eq(target.id)
  end

  it 'responds to /api/v1/invoice_items/find_all?quantity=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    other_invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    item = create(:item, merchant_id: merchant.id)
    other_item = create(:item, merchant_id: merchant.id, id: 3)
    create_list(:invoice_item, 3, item_id: other_item.id, invoice_id: other_invoice.id, quantity: 1)
    target = create(:invoice_item, item_id: item.id, invoice_id: invoice.id, quantity: 4)

    get "/api/v1/invoice_items/find_all?quantity=#{target.quantity}"

    response_invoice_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice_items.first["id"]).to eq(target.id)
  end

  it 'responds to /api/v1/invoice_items/find_all?unit_price=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    other_invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    item = create(:item, merchant_id: merchant.id)
    other_item = create(:item, merchant_id: merchant.id, id: 3)
    create_list(:invoice_item, 3, item_id: other_item.id, invoice_id: other_invoice.id, unit_price: 12345)
    target = create(:invoice_item, item_id: item.id, invoice_id: invoice.id, unit_price: 98765)

    get "/api/v1/invoice_items/find_all?unit_price=987.65"

    response_invoice_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice_items.first["id"]).to eq(target.id)
  end

  it 'responds to /api/v1/invoice_items/find_all?created_at=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    other_invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    item = create(:item, merchant_id: merchant.id)
    other_item = create(:item, merchant_id: merchant.id, id: 3)
    create_list(:invoice_item, 3, item_id: other_item.id, invoice_id: other_invoice.id)
    target = create(:invoice_item, item_id: item.id, invoice_id: invoice.id, created_at: "2012-03-27T14:57:57.000Z")

    get "/api/v1/invoice_items/find_all?created_at=#{target.created_at}"

    response_invoice_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice_items.first["id"]).to eq(target.id)
  end

  it 'responds to /api/v1/invoice_items/find_all?updated_at=x' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    other_invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    item = create(:item, merchant_id: merchant.id)
    other_item = create(:item, merchant_id: merchant.id, id: 3)
    create_list(:invoice_item, 3, item_id: other_item.id, invoice_id: other_invoice.id)
    target = create(:invoice_item, item_id: item.id, invoice_id: invoice.id, updated_at: "2012-03-27T14:57:57.000Z")

    get "/api/v1/invoice_items/find_all?updated_at=#{target.updated_at}"

    response_invoice_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice_items.first["id"]).to eq(target.id)
  end

  # relationships:

  it 'responds to /api/v1/invoice_items/:id/invoice' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    other_invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    item = create(:item, merchant_id: merchant.id)
    other_item = create(:item, merchant_id: merchant.id, id: 3)
    create_list(:invoice_item, 3, item_id: other_item.id, invoice_id: other_invoice.id)
    invoice_item = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    response_invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_invoice["id"]).to eq(invoice.id)
  end

  it 'responds to /api/v1/invoice_items/:id/item' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    item = create(:item, merchant_id: merchant.id)
    other_item = create(:item, merchant_id: merchant.id, id: 3)
    create_list(:invoice_item, 3, item_id: other_item.id, invoice_id: invoice.id)
    invoice_item = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    response_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_item["id"]).to eq(item.id)
  end
end
