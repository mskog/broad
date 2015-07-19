Rails.application.routes.draw do
  resources :feed, only: [:index]
end
