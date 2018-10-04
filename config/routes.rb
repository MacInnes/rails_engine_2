Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'merchant_search#show'
        get '/find_all', to: 'merchant_search#index'
        get '/random', to: 'random_merchant#show'
        get '/most_revenue', to: 'merchant_most_revenue#index'
      end

      scope module: :merchants do
        resources :merchants, only: [:index, :show]
      end
    end
  end

end
