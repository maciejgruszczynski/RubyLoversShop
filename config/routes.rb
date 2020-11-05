Rails.application.routes.draw do

  devise_for :admin_users
  devise_for :users

  resources :products, only: [:index, :show, :destroy] do
    collection do
      get :search
    end
  end

  get 'carts', to: 'carts#show'
  delete 'cart', to: 'carts#destroy'
  patch 'carts', to: 'carts#update'

  post 'cart_items', to: 'cart_items#create'
  patch 'cart_items', to: 'cart_items#update'
  delete 'cart_item', to: 'cart_items#destroy'

  get '/checkout/(:step)', to: 'checkout#show', as: :checkout
  patch '/checkout/(:step)', to: 'checkout#update', as: :checkout_update
  post '/checkout/make_payment', to: 'checkout#make_payment', as: :make_payment

  namespace :admin do
    resources :orders, only: :index

    root to: 'orders#index'
  end

  namespace :checkout do
    namespace :api do
      namespace :v1 do
        post 'p24/url_status'
      end
    end
  end

  root to: 'products#index'
end
