FactoryBot.define do
  factory :invoice_item do
    item_id { "" }
    invoice_id { "" }
    quantity { 1 }
    unit_price { 1 }
    item { nil }
    invoice { nil }
    created_at {"10/10/2018"}
    updated_at {"10/10/2018"}
  end
end
