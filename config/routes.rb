Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#index"

  get '/search', to: "static_pages#search"

  # resources :static_pages do
  #   get :search, on: :collection
  # end
end
