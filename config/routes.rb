Rails.application.routes.draw do

  resources :reports
  resources :cards
  resources :pages
  resources :sections
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    resources :datasets
end
