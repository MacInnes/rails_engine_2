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

  xit "responds to /api/v1/merchants/most_revenue?quantity=x" do
    get '/api/v1/merchants/most_revenue?quantity=2'

    response_merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_merchants.count).to eq(2)
    expect(response_merchants.first["id"]).to eq(@merchant_1.id)
  end

  it 'responds to /api/v1/merchants/most_items' do
    get '/api/v1/merchants/most_items?quantity=8'

    expect(response).to be_successful
  end
end