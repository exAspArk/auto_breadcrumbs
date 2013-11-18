Dummy::Application.routes.draw do
  root to: 'users#index'

  get :users, to: 'users#index'
end
