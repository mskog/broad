class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


  def self.strip_attributes; end
end
