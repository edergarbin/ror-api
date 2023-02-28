Rails.application.routes.draw do
  resources :sales
  resources :users
  resources :products
  
  post '/login', to: 'users#login'
end
