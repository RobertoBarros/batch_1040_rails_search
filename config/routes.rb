Rails.application.routes.draw do
  resources :movies, only: :index
  root to: "pages#home"
end
