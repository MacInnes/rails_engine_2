require 'rails_helper'

describe 'Customer BI endpoints' do
  it 'responds to /api/v1/customers/:id/favorite_merchant' do
    merchant = create(:merchant)
    customer = create(:customer)

    allow(Customer).to receive(:find).and_return(customer)
    allow(customer).to receive(:favorite_merchant).and_return(merchant)

    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    response_merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchant["id"]).to eq(merchant.id)
  end
end
