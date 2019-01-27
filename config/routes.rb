
Rails.application.routes.draw do
  get 'sessions/new'
  get 'welcome/index'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
 	
  resources :users do
      resources :articles 
  end
get 'tags/:tag', to: 'articles#index', as: :tag, :constraints  => { :tag => /[^\/]+/ }

  root 'welcome#index'
end