class Item < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :unit_price,
                        :created_at,
                        :updated_at

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(quantity = 5)
    select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
      .joins(invoices: [:transactions])
      .merge(Transaction.success)
      .group(:id)
      .order("total_revenue DESC")
      .limit(quantity)
  end

end
