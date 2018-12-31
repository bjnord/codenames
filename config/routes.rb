Rails.application.routes.draw do
  root to: 'games#index'
  resources :games, only: [:index, :show, :new, :create] do
    member do
      post 'set_word', to: 'games#set_word', as: 'set_word'
    end
  end
end
