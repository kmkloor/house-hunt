Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'properties#show'
  get 'status/', to: 'status#index'
  get 'status/seed/', to: 'status#seed'
  post 'status/add/', to: 'status#add'
  post 'status/update/', to: 'status#update'
  get 'properties/add', to: 'properties#add'
  post 'properties/update', to: 'properties#update'
  get ':filter', to: 'properties#show'
  post 'properties/getUrl/', to: 'properties#getUrl'
  get 'notes/all/', to: 'notes#all'
  post 'notes/delete/', to: 'notes#delete'
  post 'notes/add/', to: 'notes#add'
  post 'notes/update/', to: 'notes#update'
end
