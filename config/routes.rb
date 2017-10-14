Rails.application.routes.draw do

  devise_for :users
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
        resources :promo_codes, except: [:show, :destroy]
        resources :orders,      except: [:show, :destroy]
        resources :users,       except: [:show, :new, :create]
    end

end
