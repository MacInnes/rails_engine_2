require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many :items}
    it {should have_many :invoices}
    it {should have_many(:customers).through(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:invoice_items).through(:invoices)}
  end
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :created_at}
    it {should validate_presence_of :updated_at}
  end
end
