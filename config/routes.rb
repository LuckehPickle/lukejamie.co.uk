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
        resources :products, except: [:show, :destroy]
        resources :promo_codes,
                  except: :show,
                  path: 'promo-codes'
        resources :orders, only: [:index, :show, :edit, :update]
        resources :users,  except: [:new, :create]
        resources :support_articles,
                  except: :show,
                  path: 'support-articles'
    end

end
