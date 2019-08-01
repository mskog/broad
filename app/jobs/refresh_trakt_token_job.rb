# TODO: specs for fail
class RefreshTraktTokenJob < ActiveJob::Base
  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      refresh_credential
    end
  end

  private

  def refresh_credential
    credential = Credential.find_by_name(:trakt)
    result = Services::Trakt::Token.new.refresh(credential.data["refresh_token"])
    credential.update data: result
  end
end
