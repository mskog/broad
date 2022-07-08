# typed: strict

class Season < ApplicationRecord
  extend T::Sig

  belongs_to :tv_show
  has_many :episodes, dependent: :destroy

  scope :downloaded, ->{where(downloaded: true)}
  scope :watched, ->{where(watched: true)}

  sig{returns(T::Boolean)}
  def aired?
    episodes.all?(&:aired?) && episodes.any?
  end
end
