Rails.application.routes.draw do
  root to: "home#index"
  resources 'home', only: [:index]

  resources :episodes, only: [:index] do
    member do
      get 'download'
    end
  end

  resources :movie_downloads, only: [:create, :index, :new] do
    member do
      get 'download'
    end
  end
end
