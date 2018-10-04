FactoryBot.define do
  factory :invoice do
    merchant_id { "" }
    customer_id { "" }
    status { "MyString" }
    merchant { nil }
    customer { nil }
    created_at {"10/10/2018"}
    updated_at {"10/10/2018"}
  end
end
