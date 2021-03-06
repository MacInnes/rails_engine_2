#TODO: fix this test so it works or just delete it...

require 'rails_helper'

describe "Merchant BI" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)

    @customer = create(:customer)

    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_2.id)
    @item_3 = create(:item, merchant_id: @merchant_3.id)

    @invoice_1 = create(:invoice, customer_id: @customer.id, merchant_id: @merchant_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer.id, merchant_id: @merchant_2.id)
    @invoice_3 = create(:invoice, customer_id: @customer.id, merchant_id: @merchant_3.id)

    create_list(:invoice_item, 5, item_id: @item_1.id, invoice_id: @invoice_1.id)
    create_list(:invoice_item, 3, item_id: @item_2.id, invoice_id: @invoice_2.id)
    create_list(:invoice_item, 1, item_id: @item_3.id, invoice_id: @invoice_3.id)

    create(:transaction, invoice_id: @invoice_1.id)
    create(:transaction, invoice_id: @invoice_2.id)
    create(:transaction, invoice_id: @invoice_3.id)
    create(:transaction, result: 'failed', invoice_id: @invoice_3.id)
  end

  it "responds to /api/v1/merchants/most_revenue?quantity=x" do
    get '/api/v1/merchants/most_revenue?quantity=2'

    expect(response).to be_successful
  end

  it 'responds to /api/v1/merchants/most_items' do

    get '/api/v1/merchants/most_items?quantity=8'

    expect(response).to be_successful
  end

  it 'responds to /api/v1/merchants/revenue' do
    get '/api/v1/merchants/revenue?date=2012-03-16'

    expect(response).to be_successful
  end

  it 'responds to /api/v1/merchants/:id/revenue' do
    merchant = create(:merchant)
    get "/api/v1/merchants/#{merchant.id}/revenue"

    expect(response).to be_successful
  end

  it 'responds to /api/v1/merchants/:id/revenue?date=x' do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}/revenue?date=2012-03-16"

    expect(response).to be_successful
  end

  it 'responds to /api/v1/merchants/:id/favorite_customer' do
    merchant = build(:merchant, id: 1)
    customer = build(:customer)

    allow(Merchant).to receive(:find).and_return(merchant)
    allow(merchant).to receive(:favorite_customer).and_return(customer)

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    response_customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_customer["id"]).to eq(customer.id)

  end

  it 'responds to /api/v1/merchants/:id/customers_with_pending_invoices' do
    merchant = create(:merchant)
    customer = create(:customer)

    allow(Merchant).to receive(:find).and_return(merchant)
    allow(merchant).to receive(:pending_invoices).and_return(customer)

    get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"

    response_customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customer["id"]).to eq(customer.id)
  end
end
