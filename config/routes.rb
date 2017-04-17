Rails.application.routes.draw do
  get 'site/index'
  get 'site/dashboard'
  get '/settings', to: 'site#settings'

  post '/get_columns', to: "site#get_dataset_columns"
  post '/get_actions', to: "site#get_column_actions"
  post '/do-action', to: "site#do_action"
  post '/var_test', to: "site#variable_test"

  post '/save_section_layout', to: "site#save_section_layout"
  post '/change_section_name', to: "site#change_section_name"


  root 'site#index'

  get '/dashboard', to: 'site#dashboard'
  post '/dashboard', to: 'site#dashboard'
  
  post '/cards/text/preview', to: 'cards#preview'
  
  resources :reports
  resources :cards
  resources :sections
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :datasets

end
