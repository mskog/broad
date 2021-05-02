require 'sidekiq/web'
Sidekiq::Web.use Rack::Auth::Basic do |username, password|
 username == ENV["HTTP_USERNAME"] && password == ENV["HTTP_PASSWORD"]
end

Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"
  resources :episodes, only: [:index] do
    member do
      get 'download'
    end
  end

  resources :movie_downloads, only: [:create, :index] do
    member do
      get 'download'
    end
  end

  resources :ptp_movie_recommendations, only: [:index]

  resources :posters, only: [:show]

  namespace :api do
    namespace :v1 do
      resources :movie_waitlists, only: [:create, :destroy] do
        member do
          patch :force
        end
      end
      resources :movie_searches, only: [:index]
      resources :tv_show_searches, only: [:index]
      resources :movie_acceptable_releases, only: [:show]
      resources :movie_search_details, only: [:show]
      resources :tv_show_details, only: [:show]
      resources :movies, only: [:index, :show]
      resources :movie_downloads, only: [:create]
      resources :posters, only: [:show]
      resources :images, only: [:index]
      resources :episodes, only: [:index, :show]
      resource :tv_shows_calendar, only: [:show]
      resources :tv_shows, only: [:index, :show] do
        resources :episodes, only: :index, controller: "tv_show_episodes"
        member do
          patch :sample
          patch :collect
          patch :watching
          patch :not_watching
        end
      end
      resources :movie_recommendations, only: [:index, :destroy] do
        member do
          put 'download'
        end
      end
    end
  end

  mount Sidekiq::Web => '/sidekiq'
end
