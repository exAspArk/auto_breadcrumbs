Dummy::Application.routes.draw do
  root to: 'users#index'

  resource :users, only: [:index]
end
