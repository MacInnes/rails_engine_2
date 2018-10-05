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

  it 'responds to /api/v1/items/find?id=x' do
    merchant = create(:merchant)
    items = create_list(:item, 5, merchant_id: merchant.id)

    get "/api/v1/items/find?id=#{items.first.id}"

    response_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_items["id"]).to eq(items.first.id)
  end

  it 'responds to /api/v1/items/find_all?name=x' do
    merchant = create(:merchant)
    items = create_list(:item, 5, merchant_id: merchant.id)

    get "/api/v1/items/find_all?name=#{items.first.name}"

    response_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_items.length).to eq(5)
  end

  it 'responds to /api/v1/items/find_all?created_at=x' do
    merchant = create(:merchant)
    target_date = "2012-03-27 14:53:59"
    target_item = create(:item, merchant_id: merchant.id, created_at: target_date)
    items = create_list(:item, 5, merchant_id: merchant.id)

    get "/api/v1/items/find_all?created_at=#{items.first.created_at}"

    response_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_items.length).to eq(5)
  end

  it 'responds to /api/v1/items/find_all?updated_at=x' do
    merchant = create(:merchant)
    target_date = "2012-03-27 14:53:59"
    target_item = create(:item, merchant_id: merchant.id, updated_at: target_date)
    items = create_list(:item, 5, merchant_id: merchant.id)

    get "/api/v1/items/find_all?updated_at=#{items.first.created_at}"

    response_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_items.length).to eq(5)
  end

  it 'responds to /api/v1/items/find_all?description=asdf' do
    merchant = create(:merchant)
    valid_items = create_list(:item, 5, merchant_id: merchant.id, description: "asdf")
    invalid_items = create_list(:item, 3, merchant_id: merchant.id, description: "giuwie")

    get "/api/v1/items/find_all?description=asdf"

    response_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_items.length).to eq(5)
    expect(response_items.first["description"]).to eq("asdf")
  end

  it 'responds to /api/v1/items/find_all?unit_price=123' do

  end

  it 'responds to /api/v1/items/find_all?merchant_id=x' do
    merchant = create(:merchant)
    valid_items = create_list(:item, 5, merchant_id: merchant.id, unit_price: 123)
    invalid_items = create_list(:item, 3, merchant_id: merchant.id, unit_price: 12345)

    get "/api/v1/items/find_all?unit_price=123"

    response_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_items.length).to eq(5)
    expect(response_items.first["unit_price"]).to eq("1.23")
  end

end
