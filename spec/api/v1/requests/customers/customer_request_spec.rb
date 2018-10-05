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
    target = create(:customer)
    create_list(:customer, 4)

    get "/api/v1/customers/#{target.id}"

    response_customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customer["id"]).to eq(target.id)
  end
end
