Rails.application.routes.draw do

  resources :products, only: [:index, :show] do
    collection do
      get 'search'
    end
  end

  root to: "products#index"

end
