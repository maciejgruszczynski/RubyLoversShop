Rails.application.routes.draw do

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

  namespace :admin do
    resources :orders, only: [:index]

    root to: 'orders#index'
  end

  root to: 'products#index'

end
