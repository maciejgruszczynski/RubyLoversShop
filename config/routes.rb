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

  resource :orders


  root to: 'products#index'

end
