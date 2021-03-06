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

  def self.revenue_by_date(date)
    date = date.to_date
    select("SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
      .joins(invoices: [:transactions, :invoice_items])
      .merge(Transaction.success)
      .where("invoices.created_at BETWEEN ? AND ?", date.beginning_of_day, date.end_of_day)
      .limit(1)
      .take
  end

  def revenue
    invoices.select("SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
      .joins(:invoice_items, :transactions)
      .merge(Transaction.success)
      .limit(1)
      .take
  end

  def revenue_by_date(date)
    date = date.to_date
    invoices.select("SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
      .joins(:invoice_items, :transactions)
      .merge(Transaction.success)
      .where("invoices.created_at BETWEEN ? AND ?", date.beginning_of_day, date.end_of_day)
      .limit(1)
      .take
  end

  def favorite_customer
    customers.select("customers.*, COUNT(customers.id) AS invoice_count")
      .joins(:invoices)
      .group(:id)
      .order("invoice_count DESC")
      .limit(1)
      .take
  end

  def pending_invoices
    customers.find_by_sql("SELECT customers.* FROM customers
      INNER JOIN invoices ON customers.id = invoices.customer_id
      INNER JOIN transactions ON transactions.invoice_id = invoices.id
      WHERE invoices.merchant_id = #{id}
      EXCEPT
      SELECT customers.* FROM customers
      INNER JOIN invoices ON customers.id = invoices.customer_id
      INNER JOIN transactions ON transactions.invoice_id = invoices.id
      WHERE transactions.result = 'success' AND invoices.merchant_id = #{id};")
  end

end
