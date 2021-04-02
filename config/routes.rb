Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  post 'welcome/getUrl/', to: 'welcome#getUrl'
  get 'properties/add', to: 'properties#add'
  get 'properties/show', to: 'properties#show'
  post 'properties/getUrl/', to: 'properties#getUrl'
end
