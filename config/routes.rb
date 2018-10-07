Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'merchant_search#show'
        get '/find_all', to: 'merchant_search#index'
        get '/random', to: 'random_merchant#show'
        get '/most_revenue', to: 'merchant_most_revenue#index'
        get '/most_items', to: 'merchant_most_items#index'
        get '/revenue', to: 'merchant_revenue#index'
        get '/:merchant_id/revenue', to: 'single_merchant_revenue#show'
        get '/:merchant_id/favorite_customer', to: 'favorite_customer#show'
        get '/:merchant_id/items', to: 'merchant_items#index'
        get '/:merchant_id/invoices', to: 'merchant_invoices#index'
      end

      scope module: :merchants do
        resources :merchants, only: [:index, :show]
      end

      namespace :items do
        get '/find', to: 'items_search#show'
        get '/find_all', to: 'items_search#index'
        get '/:item_id/invoice_items', to: 'item_invoice_items#index'
        get '/:item_id/merchant', to: 'item_merchant#show'
        get '/most_revenue', to: 'item_revenue#index'
        get '/most_items', to: 'item_count#index'
        get '/:id/best_day', to: 'item_best_day#show'
      end

      scope module: :items do
        resources :items, only: [:index, :show]
      end

      namespace :invoices do
        get '/find', to: 'invoice_search#show'
        get '/find_all', to: 'invoice_search#index'
        get '/:invoice_id/transactions', to: 'invoice_transactions#index'
        get '/:invoice_id/invoice_items', to: 'invoice_invoice_items#index'
        get '/:invoice_id/items', to: 'invoice_items#index'
        get '/:invoice_id/customer', to: 'invoice_customer#show'
        get '/:invoice_id/merchant', to: 'invoice_merchant#show'
      end

      scope module: :invoices do
        resources :invoices, only: [:index, :show]
      end

      namespace :customers do
        get '/find', to: 'customer_search#show'
        get '/find_all', to: 'customer_search#index'
        get '/:customer_id/invoices', to: 'customer_invoices#index'
        get '/:customer_id/transactions', to: 'customer_transactions#index'
        get '/:customer_id/favorite_merchant', to: 'customer_favorite_merchant#show'
      end

      scope module: :customers do
        resources :customers, only: [:index, :show]
      end

      namespace :invoice_items do
        get '/find', to: 'invoice_items_search#show'
        get '/find_all', to: 'invoice_items_search#index'
        get '/:invoice_item_id/invoice', to: 'invoice_items_invoice#show'
        get '/:invoice_item_id/item', to: 'invoice_items_item#show'
      end

      scope module: :invoice_items do
        resources :invoice_items, only: [:index, :show]
      end

      namespace :transactions do
        get '/find', to: 'transactions_search#show'
        get '/find_all', to: 'transactions_search#index'
        get '/:transaction_id/invoice', to: 'transaction_invoice#show'
      end

      scope module: :transactions do
        resources :transactions, only: [:index, :show]
      end
    end
  end

end
