Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items, only: [:index, :new, :create, :show, :edit, :update] do
    collection do
      get 'calculated'
    end
  end
end
