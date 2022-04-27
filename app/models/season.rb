class Season < ApplicationRecord
  belongs_to :tv_show
  has_many :episodes, dependent: :destroy

  scope :downloaded, ->{where(downloaded: true)}
  scope :watched, ->{where(watched: true)}
end
