Rails.application.routes.draw do
  root to: 'games#index'
  resources :games, only: [:index, :show, :new, :create] do
    member do
      get 'get_word', to: 'games#get_word', as: 'get_word'
      post 'set_word', to: 'games#set_word', as: 'set_word'
      post 'set_who', to: 'games#set_who', as: 'set_who'
      post 'reveal', to: 'games#reveal', as: 'reveal'
    end
  end
  resources :pins, only: [:index, :create];
  get '/about', to: 'pages#about', as: 'about'
  get '/contact', to: 'pages#contact', as: 'contact'
end
