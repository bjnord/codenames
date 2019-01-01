Rails.application.routes.draw do
  root to: 'games#index'
  resources :games, only: [:index, :show, :new, :create] do
    member do
      post 'set_word', to: 'games#set_word', as: 'set_word'
      post 'set_who', to: 'games#set_who', as: 'set_who'
      post 'reveal', to: 'games#reveal', as: 'reveal'
    end
  end
end
