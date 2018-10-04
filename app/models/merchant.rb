class Merchant < ApplicationRecord
  validates_presence_of :name,
                        :created_at,
                        :updated_at

  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.most_revenue(limit = 5)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS merchant_revenue")
      .joins(invoices: [:transactions, :invoice_items])
      .merge(Transaction.success)
      .group(:id)
      .order("merchant_revenue DESC")
      .limit(limit)
  end

  def self.most_items_sold(limit = 5)
    select("merchants.*, SUM(invoice_items.quantity) AS item_count")
      .joins(invoices: [:transactions, :invoice_items])
      .merge(Transaction.success)
      .group(:id)
      .order("item_count DESC")
      .limit(limit)
  end

end
