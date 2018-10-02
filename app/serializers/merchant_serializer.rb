class MerchantSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :items
  has_many :invoices
  has_many :customers
  has_many :transactions
  has_many :invoice_items
end
