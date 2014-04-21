Dummy::Application.routes.draw do
  root to: 'users#index'

  resources :users, only: [:index, :show, :edit] do
    get :sync, on: :collection
    member do
      get :dup
      get :ban
    end
  end

  resources :country_names, only: [:index]

  resources :cities, only: [:index, :edit, :show] do
    resources :users, only: :show
  end
end
