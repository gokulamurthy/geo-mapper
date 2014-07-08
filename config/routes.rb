Rails.application.routes.draw do
  resources :users do
    get 'show_map', to: 'users#show_map'
  end
  
  get 'user_is_night', to: 'users#is_night', as: 'user_is_night'
  get 'signup', to: 'users#new', as: 'signup'
  
end
