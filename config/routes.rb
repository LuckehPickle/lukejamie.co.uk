Rails.application.routes.draw do

    devise_for :users,
               path: 'auth',
               controllers: {
                   sessions: 'user/sessions',
                   registrations: 'user/registrations'
               },
               path_names: {
                   sign_in: 'login',
                   sign_out: 'logout',
                   sign_up: 'register'
               }

    root 'welcome#index'
    resources :products, only: [:index, :show]

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
        resources :products,    except: [:show, :destroy]
        resources :promo_codes, except: :show, path: 'promo-codes'
        resources :orders,        only: [:index, :edit, :update]
        resources :users,       except: [:new, :create]
    end

end
