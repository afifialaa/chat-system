Rails.application.routes.draw do

  # User routes
  post '/user/login', to: 'sessions#login'
  delete '/user/logout', to: 'sessions#destroy'

  post '/user/create', to: 'users#create'
  delete '/user/delete', to: 'users#delete'

  # Application routes
  post '/application/create', to: 'applications#create' # Create new application
  delete '/application/:token/delete', to: 'applications#delete' # Deletw application
  put '/application/:token/:name', to: 'applications#update' # Rename application
  get '/applications/:token', to: 'applications#show' # Find application and all its chats

  # Chat routes
  post '/applications/:token/chats/create', to: 'chats#create' # Create a new chat
  get '/applications/:token/chats/:num', to: 'chats#show' # Display all messages in chat from all participants
  delete '/applications/:token/chats/delete/:num', to: 'chats#delete' # Delete a chat

  post '/applications/:token/chats/:num/join', to: 'chats#join' # User joins specific chat
  delete '/applications/:token/chats/:num/exit', to: 'chats#exit' # User exits chats

  # Messages routes
  post '/application/:token/chats/:num/message', to: 'messages#create'
  delete '/application/:token/chats/:num/message/delete/:message_id', to: 'messages#delete'
  get '/application/:token/chats/:num/message/search/:query', to: 'messages#search'
end
