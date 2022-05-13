class Season < ApplicationRecord
  belongs_to :tv_show
  has_many :episodes, dependent: :destroy

  scope :downloaded, ->{where(downloaded: true)}
  scope :watched, ->{where(watched: true)}

  def aired?
    episodes.all?(&:aired?) && episodes.any?
  end
end
