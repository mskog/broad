class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  include ActionController::Caching

  def self.setup_auth
    http_basic_authenticate_with name: ENV["HTTP_USERNAME"], password: ENV["HTTP_PASSWORD"], except: :download if Rails.env.production?
  end

  setup_auth

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
end
