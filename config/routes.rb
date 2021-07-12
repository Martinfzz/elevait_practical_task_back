Rails.application.routes.draw do
  resources :pages, only: [:index, :show, :create]
  resources :documents, except: [:nex, :edit]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
