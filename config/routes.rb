Rails.application.routes.draw do
  root to: 'main#index' 
  resources :tasks do
    member do 
      patch 'completed'
    end
  end
  get "user/new", to: 'auth#new'
  get "user", to: 'auth#login', as: :login
  post "user", to: 'auth#create'
  delete "logout", to: 'auth#destroy'
end
