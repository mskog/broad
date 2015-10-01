Rails.application.routes.draw do
  resources :episodes, only: [:index] do
    member do
      get 'download'
    end
  end

  resources :movies, only: [:create, :index] do
    member do
      get 'download'
    end
  end
end
