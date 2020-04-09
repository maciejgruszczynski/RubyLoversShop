Rails.application.routes.draw do

  root to: "products#index"
  resources :products, only: [:index, :show]

end
