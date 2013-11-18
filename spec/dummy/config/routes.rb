Dummy::Application.routes.draw do
  root to: 'users#index'

  resources :users, only: [:index, :show, :edit] do
    get :sync, on: :collection
    get :dup,  on: :member
  end
end
