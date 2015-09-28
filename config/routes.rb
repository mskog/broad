Rails.application.routes.draw do
  resources :episodes, only: [:index] do
    member do
      get 'download'
    end
  end

  resources :movie_releases, only: [:create]
end
