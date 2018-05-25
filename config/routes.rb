Rails.application.routes.draw do
  root 'front#index'
  get '/admin', to: 'front#admin'
  post '/admin', to: 'front#fix_rate'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
