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

  resources :movie_downloads, only: [:index] do
    member do
      get 'download'
    end
  end

  resources :ptp_movie_recommendations, only: [:index]

  mount Sidekiq::Web => '/sidekiq'
end
