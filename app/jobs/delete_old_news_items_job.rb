class DeleteOldNewsItemsJob < ActiveJob::Base
  queue_as :default

  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      NewsItem.where("created_at < ?", 90.days.ago).delete_all
    end
  end
end
