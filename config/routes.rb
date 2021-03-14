Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # User routes
  post '/user/login', to: 'sessions#login'
  delete '/user/logout', to: 'sessions#destroy'
  get '/user/search', to: 'sessions#show'

  post '/user/create', to: 'users#create'
  delete '/user/delete', to: 'users#delete'

  # Application routes
  post '/application/create', to: 'applications#create'
  delete '/application/delete/:token', to: 'applications#delete'
  put '/application/update/:token/:name', to: 'applications#update'

  # Chat routes
  post '/applications/:token/chats/create', to: 'chats#create'
  get '/applications/:token/chats/search/:num', to: 'chats#show'
  delete '/applications/:token/chats/delete/:num', to: 'chats#delete'

  post '/applications/:token/chats/:num/join', to: 'chats#join'
  delete '/applications/:token/chats/:num/exit', to: 'chats#exit'

  # Messages routes
  post '/application/:token/chats/:num/message', to: 'messages#create'
  delete '/application/:token/chats/:num/message/delete/:message_id', to: 'messages#delete'
  get '/application/:token/chats/:num/message/search/:query', to: 'messages#search'
end
