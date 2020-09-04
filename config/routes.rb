Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items do
    collection do
      get 'calculated'
    end
    resources :orders, only: [:new, :create]
  end
end
