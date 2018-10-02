require 'csv'

task :import_data => :environment do
  puts "Importing merchants..."
  merchant_csv_text = File.read('db/csv/merchants.csv')
  merchant_csv = CSV.parse(merchant_csv_text, :headers => true)
  merchant_csv.each do |row|
    Merchant.create!(row.to_hash)
  end
  puts "Imported #{Merchant.count} merchants."

  puts "Importing customers..."
  customer_csv_text = File.read('db/csv/customers.csv')
  customer_csv = CSV.parse(customer_csv_text, :headers => true)
  customer_csv.each do |row|
    Customer.create!(row.to_hash)
  end
  puts "Imported #{Customer.count} customers."

  puts "Importing invoices..."
  invoice_csv_text = File.read('db/csv/invoices.csv')
  invoice_csv = CSV.parse(invoice_csv_text, :headers => true)
  invoice_csv.each do |row|
    Invoice.create!(row.to_hash)
  end
  puts "Imported #{Invoice.count} invoices."

  puts "Importing transactions..."
  transaction_csv_text = File.read('db/csv/transactions.csv')
  transaction_csv = CSV.parse(transaction_csv_text, :headers => true)
  transaction_csv.each do |row|
    Transaction.create!(row.to_hash)
  end
  puts "Imported #{Transaction.count} transactions."

  puts "Importing items..."
  item_csv_text = File.read('db/csv/items.csv')
  item_csv = CSV.parse(item_csv_text, :headers => true)
  item_csv.each do |row|
    Item.create!(row.to_hash)
  end
  puts "Imported #{Item.count} items"

  puts "Importing invoice items..."
  invoice_items_csv_text = File.read('db/csv/invoice_items.csv')
  invoice_items_csv = CSV.parse(invoice_items_csv_text, :headers => true)
  invoice_items_csv.each do |row|
    InvoiceItem.create!(row.to_hash)
  end
  puts "Imported #{InvoiceItem.count} invoice items"
end
