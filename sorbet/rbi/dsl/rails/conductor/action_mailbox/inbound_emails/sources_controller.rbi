# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `Rails::Conductor::ActionMailbox::InboundEmails::SourcesController`.
# Please instead update this file by running `bin/tapioca dsl Rails::Conductor::ActionMailbox::InboundEmails::SourcesController`.

class Rails::Conductor::ActionMailbox::InboundEmails::SourcesController
  sig { returns(HelperProxy) }
  def helpers; end

  module HelperMethods
    include ::ActionText::ContentHelper
    include ::ActionText::TagHelper
    include ::ActionController::Base::HelperMethods
    include ::ApplicationHelper
    include ::DateHelper
    include ::JavascriptHelper
  end

  class HelperProxy < ::ActionView::Base
    include HelperMethods
  end
end
