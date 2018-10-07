class Customer < ApplicationRecord
  validates_presence_of :first_name,
                       :last_name,
                       :created_at,
                       :updated_at
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def favorite_merchant
    merchants.select("merchants.*, transactions.count AS count")
      .joins(:transactions)
      .merge(Transaction.success)
      .group("merchants.id")
      .order("count DESC")
      .limit(1)
      .take
  end

end
