Rails.application.routes.draw do

    devise_for :users,
               path: 'auth',
               controllers: {
                   confirmations: 'user/confirmations',
                   passwords: 'user/passwords',
                   registrations: 'user/registrations',
                   sessions: 'user/sessions'
               },
               path_names: {
                   sign_in: 'login',
                   sign_out: 'logout',
                   sign_up: 'register'
               }

    root 'welcome#index'
    resources :products, only: [:index, :show]

    resources :support_articles,
              path: 'support',
              only: [:index, :show]

    namespace :account do
        root 'users#show'
        resources :addresses, except: :show
        resources :orders, only: [:index, :show]
        get '/settings',   to: 'users#edit'
        match '/settings', to: 'users#update',  via: [:patch, :put]
        match '/delete',   to: 'users#destroy', via: :delete
    end

    namespace :admin do
        root 'admin#index'

        get '/products/search', to: 'products#search'
        resources :products, except: [:show, :destroy]

        get '/promo-codes/search', to: 'promo_codes#search'
        resources :promo_codes, except: :show, path: 'promo-codes'

        get '/orders/search', to: 'orders#search'
        resources :orders, only: [:index, :show, :edit, :update]

        get '/users/search', to: 'users#search'
        resources :users,  except: [:new, :create]

        get '/support/search',   to: 'support_articles#search'
        match '/support/delete', to: 'support_articles#destroy_many', via: :delete
        resources :support_articles, except: :show, path: 'support'

    end

end
