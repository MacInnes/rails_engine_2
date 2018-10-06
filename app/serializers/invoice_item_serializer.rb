class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :invoice_id, :item_id, :quantity, :unit_price

  def unit_price
    "%.2f" % (object.unit_price.to_f / 100)
  end
end
