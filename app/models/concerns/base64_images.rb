module Base64Images
  extend ActiveSupport::Concern

  class_methods do
    def base64_image(*methods)
      methods.each do |method|
        define_method "#{method}_base64" do
          return nil unless Rails.application.config.action_controller.perform_caching
          base64 = Rails.cache.read("base64_#{send(method)}")
          return "data:image/jpeg;base64,#{base64}" if base64.present?

          CacheBase64ImageJob.perform_later(send(method)) and return nil
        end
      end
    end
  end
end
