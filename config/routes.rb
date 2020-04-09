Rails.application.routes.draw do
  
  root to: "test#index"
  resources :products, only: [:index, :show]

end
