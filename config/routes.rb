require 'sidekiq/web'
Sidekiq::Web.use Rack::Auth::Basic do |username, password|
 username == ENV["HTTP_USERNAME"] && password == ENV["HTTP_PASSWORD"]
end

Rails.application.routes.draw do
  concern :paginatable do
    get '(page/:page)', :action => :index, :on => :collection, :as => ''
  end

  root to: "home#index"
  resources 'home', only: [:index]

  resources :episodes, only: [:index], :concerns => :paginatable do
    member do
      get 'download'
    end
  end

  resources :movie_downloads, only: [:create, :index], :concerns => :paginatable do
    member do
      get 'download'
    end
  end

  resources :movie_waitlists, only: [:create, :index], :concerns => :paginatable do
    member do
      put 'force'
    end
  end

  resources :watched_movies, only: [:index]

  resource :search
  resources :movies, only: [:destroy, :show]

  resources :tv_shows, only: [:index, :show], :concerns => :paginatable do
    collection do
      post :sample
    end

    member do
      patch :watching
      patch :not_watching
      patch :collect
    end
  end

  resources :tv_shows_calendar, only: [:index]

  resources :posters, only: [:show]

  namespace :api do
    namespace :v1 do
      resources :movie_waitlists, only: [:create]
      resources :movie_searches, only: [:index]
      resources :tv_show_searches, only: [:index]
      resources :movie_acceptable_releases, only: [:show]
      resources :movie_search_details, only: [:show]
      resources :tv_show_details, only: [:show]
      resources :movie_recommendations, only: [:index, :destroy] do
        member do
          put 'download'
        end
      end
    end
  end

  mount Sidekiq::Web => '/sidekiq'
end
