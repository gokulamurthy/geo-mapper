Rails.application.routes.draw do
  resources :users do
    get 'show_map', to: 'users#show_map'
  end
  
  get 'signup', to: 'users#new', as: 'signup'
  
end
