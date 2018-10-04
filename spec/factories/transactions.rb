FactoryBot.define do
  factory :transaction do
    invoice_id { "" }
    credit_card_number { "MyString" }
    credit_card_expiration_date { "MyString" }
    result { "MyString" }
    invoice { nil }
    created_at {"10/10/2018"}
    updated_at {"10/10/2018"}
  end
end
