class Season < ApplicationRecord
  belongs_to :tv_show
  has_many :episodes, dependent: :destroy
end
