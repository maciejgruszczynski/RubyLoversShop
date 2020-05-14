Rails.application.routes.draw do

  resources :products, only: [:index, :show, :destroy] do
    collection do
      get :search
    end
  end

  get 'carts', to: 'carts#show'
  delete 'cart', to: 'carts#destroy'
  post 'cart_items', to: 'cart_items#create'
  patch 'cart_items', to: 'cart_items#update'


  root to: 'products#index'

end
