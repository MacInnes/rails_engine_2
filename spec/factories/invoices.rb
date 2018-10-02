FactoryBot.define do
  factory :invoice do
    merchant_id { "" }
    customer_id { "" }
    status { "MyString" }
    merchant { nil }
    customer { nil }
  end
end
