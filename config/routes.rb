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

  resources :movie_downloads, only: [:create, :index] do
    member do
      get 'download'
    end
  end

  resources :movie_waitlists, only: [:create, :index]
  resources :movie_searches, only: [:create, :index]
  resources :movies, only: [:destroy, :show]

  mount Sidekiq::Web => '/sidekiq'
end
