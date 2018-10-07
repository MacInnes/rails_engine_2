require 'rails_helper'

describe 'item BI endpoints' do
  it 'responds to /api/v1/items/most_revenue?quantity=x' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    other_item = create(:item, merchant_id: merchant.id)

    allow(Item).to receive(:most_revenue).and_return([item])

    get "/api/v1/items/most_revenue?quantity=1"

    response_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_item.first["id"]).to eq(item.id)
  end

  it 'responds to /api/v1/items/most_items?quantity=x' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    other_item = create(:item, merchant_id: merchant.id)

    allow(Item).to receive(:most_items).and_return([item])

    get "/api/v1/items/most_items?quantity=1"

    response_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_item.first["id"]).to eq(item.id)
  end

  it 'responds to /api/v1/items/:id/best_day' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    other_item = create(:item, merchant_id: merchant.id)
    date = "2012-03-23T10:55:29.000Z"

    allow(Item).to receive(:find).and_return(item)
    allow(item).to receive(:best_day).and_return({best_day: date})

    get "/api/v1/items/:id/best_day"

    response_date = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_date["best_day"]).to eq(date)
  end
end
