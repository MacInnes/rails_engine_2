require 'rails_helper'

describe 'Merchant endpoints' do
  it 'responds to /api/v1/merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants.length).to eq(3)
  end

  it 'responds to /api/v1/merchants/:id' do
    target_merchant = create(:merchant)
    create_list(:merchant, 3)

    get "/api/v1/merchants/#{target_merchant.id}"

    actual_merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(actual_merchant["id"]).to eq(target_merchant.id)
  end

  it 'responds to /api/v1/merchants/find?id=:id' do
    target_merchant = create(:merchant)
    create_list(:merchant, 3)

    get "/api/v1/merchants/find?id=#{target_merchant.id}"

    actual_merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(actual_merchant["id"]).to eq(target_merchant.id)
  end

  it 'responds to /api/v1/merchants/find?name=some_name' do
    other_merchant = create(:merchant)
    merchant = create(:merchant, name: "asdf")

    get "/api/v1/merchants/find?name=#{merchant.name}"

    response_merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_merchant["id"]).to_not eq(other_merchant.id)
    expect(response_merchant["id"]).to eq(merchant.id)
  end

  it 'responds to /api/v1/merchants/find?created_at=123' do
    other_merchant = create(:merchant)
    merchant = create(:merchant, created_at: '123')

    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"

    response_merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_merchant["id"]).to_not eq(other_merchant.id)
    expect(response_merchant["id"]).to eq(merchant.id)
  end

  it 'responds to /api/v1/merchants/find?updated_at=123' do
    other_merchant = create(:merchant)
    merchant = create(:merchant, updated_at: '123')

    get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"

    response_merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_merchant["id"]).to_not eq(other_merchant.id)
    expect(response_merchant["id"]).to eq(merchant.id)
  end

  it 'responds to /api/v1/merchants/find_all?id=:id' do
    target_merchant = create(:merchant)
    create_list(:merchant, 3)

    get "/api/v1/merchants/find_all?id=#{target_merchant.id}"

    actual_merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(actual_merchant.first["id"]).to eq(target_merchant.id)
  end

  it 'responds to /api/v1/merchants/find_all?name=some_name' do
    create_list(:merchant, 5)
    create_list(:merchant, 3, name: "asdf")

    get "/api/v1/merchants/find_all?name=asdf"

    response_merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_merchants.length).to eq(3)
  end

  it 'responds to /api/v1/merchants/find_all?created_at=123' do
    created_at = '2012-03-27 14:54:09 UTC'
    create_list(:merchant, 5)
    create_list(:merchant, 3, created_at: created_at)

    get "/api/v1/merchants/find_all?created_at=#{created_at}"

    response_merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_merchants.length).to eq(3)
  end

  it 'responds to /api/v1/merchants/find_all?updated_at=123' do
    updated_at = '2012-03-27 14:54:09 UTC'
    create_list(:merchant, 5)
    create_list(:merchant, 3, updated_at: updated_at)

    get "/api/v1/merchants/find_all?updated_at=#{updated_at}"

    response_merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_merchants.length).to eq(3)
  end

  it 'responds to /api/v1/merchants/random' do
    create_list(:merchant, 5)

    get '/api/v1/merchants/random'

    expect(response).to be_successful
  end

end
