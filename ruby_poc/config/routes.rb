Rails.application.routes.draw do
  resources :uploads, only: :create
  resources :status, only: :show
end
