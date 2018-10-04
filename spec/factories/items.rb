FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyString" }
    unit_price { 1 }
    merchant_id { "" }
    merchant { nil }
    created_at {"10/10/2018"}
    updated_at {"10/10/2018"}
  end
end
