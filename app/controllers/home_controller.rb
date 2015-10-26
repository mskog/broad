class HomeController < ApplicationController  
  def index
    @view = DashboardDecorator.new(ViewObjects::Dashboard.new)
  end
end
