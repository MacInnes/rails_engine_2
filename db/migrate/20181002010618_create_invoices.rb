class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.bigint :merchant_id
      t.bigint :customer_id
      t.string :status
      t.references :merchant, foreign_key: true
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
