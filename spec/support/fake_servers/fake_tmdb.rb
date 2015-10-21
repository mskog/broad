require 'sinatra/base'

class FakeTmdb < Sinatra::Base
  get '/*' do
    raise NotImplementedError, "'#{self.url}' is not implemented in this fake"
  end

  private

  class NotImplementedError < StandardError; end
end
