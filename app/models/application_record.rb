# typed: strict

class ApplicationRecord < ActiveRecord::Base
  extend T::Sig

  self.abstract_class = true

  sig{returns(NilClass)}
  def self.strip_attributes; end
end
