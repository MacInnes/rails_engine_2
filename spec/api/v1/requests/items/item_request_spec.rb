require 'rails_helper'

describe 'Item endpoints' do
  it 'responds to /api/v1/items' do
    merchant = create(:merchant)
    items = create_list(:item, 5, merchant_id: merchant.id)

    get '/api/v1/items'

    response_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_items.length).to eq(5)
  end

  it 'responds to /api/v1/items/:id' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}"

    response_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_item["id"]).to eq(item.id)
  end

end
