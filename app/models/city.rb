class City < ApplicationRecord
  belongs_to :state
  has_many :neighbours
  validates :name, presence: true
end
