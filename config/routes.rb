Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'properties#show'
  get 'status/', to: 'status#index'
  get 'status/seed/', to: 'status#seed'
  get 'properties/add', to: 'properties#add'
  post 'properties/update', to: 'properties#update'
  get 'properties/show', to: 'properties#show'
  get 'properties/show/:filter', to: 'properties#show'
  post 'properties/show', to: 'properties#show'
  get 'properties/edit/:id', to: 'properties#edit'
  post 'properties/getUrl/', to: 'properties#getUrl'
end
