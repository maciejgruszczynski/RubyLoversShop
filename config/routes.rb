Rails.application.routes.draw do

  resources :products, only: [:index, :show, :destroy] do
    collection do
      get :search
    end
    member do
      post :add_to_cart
      delete :remove_from_cart
    end
  end

  get 'carts', to: 'carts#show'
  delete 'cart', to: 'carts#destroy'
  resources :carts, only: [:update, :destroy]

  resources :cart_items, only: [:create, :update, :destroy]

  root to: 'products#index'

end
