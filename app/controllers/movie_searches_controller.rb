class MovieSearchesController < ApplicationController
  def index
    render react_component: 'MovieSearch', props: {query: params[:query]}
  end
end
