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

  it 'responds to /api/v1/items/find?id=x' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/find?id=#{item.id}"

    response_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_item["id"]).to eq(item.id)
  end

  it 'responds to /api/v1/items/find?name=x' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/find?name=#{item.name}"

    response_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_item["id"]).to eq(item.id)
  end

  it 'responds to /api/v1/items/find?created_at=x' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/find?created_at=#{item.created_at}"

    response_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_item["id"]).to eq(item.id)
  end

  it 'responds to /api/v1/items/find?updated_at=x' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/find?updated_at=#{item.updated_at}"

    response_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_item["id"]).to eq(item.id)
  end

  #multi_finders:

  it 'responds to /api/v1/items/find_all?name=x' do
    merchant = create(:merchant)
    items = create_list(:item, 5, merchant_id: merchant.id)

    get "/api/v1/items/find_all?name=#{items.first.name}"

    response_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_items.length).to eq(5)
  end

end
