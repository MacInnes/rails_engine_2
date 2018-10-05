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
      end

      scope module: :merchants do
        resources :merchants, only: [:index, :show]
      end

      namespace :items do
        get '/find', to: 'items_search#show'
        get '/find_all', to: 'items_search#index'
      end

      scope module: :items do
        resources :items, only: [:index, :show]
      end

      namespace :invoices do
        get '/find', to: 'invoice_search#show'
        get '/find_all', to: 'invoice_search#index'
      end

      scope module: :invoices do
        resources :invoices, only: [:index, :show]
      end
    end
  end

end
