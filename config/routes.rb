Rails.application.routes.draw do
  get 'site/index'
  get 'site/dashboard'




  root 'site#index'

  get '/dashboard', to: 'site#dashboard'
  post '/dashboard', to: 'site#dashboard'
  resources :reports
  resources :cards
  resources :sections
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :datasets

end
