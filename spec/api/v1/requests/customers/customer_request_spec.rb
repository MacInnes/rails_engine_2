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

end
