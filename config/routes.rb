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

  resources :carts, only: [:show, :update] do
    member do
      post :clean_cart
    end
  end

  resources :cart_items, only: [:create, :update, :destroy]

  root to: 'products#index'

end
