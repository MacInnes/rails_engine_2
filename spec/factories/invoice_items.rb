FactoryBot.define do
  factory :invoice_item do
    item_id { "" }
    invoice_id { "" }
    quantity { 1 }
    unit_price { 1 }
    item { nil }
    invoice { nil }
  end
end
