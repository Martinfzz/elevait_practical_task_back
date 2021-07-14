Rails.application.routes.draw do
  resources :pages, only: [:index, :show, :create]
  resources :documents, only: [:index, :show, :create]
end
