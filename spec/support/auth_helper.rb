module AuthHelper
  def http_login
    @env ||= {}
    user = ENV['HTTP_USERNAME']
    pw = ENV['HTTP_PASSWORD']
    @env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end  
end
