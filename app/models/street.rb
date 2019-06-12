class Street < ApplicationRecord
  belongs_to :neighbour
  has_many :occurrences
  validates :name, :cep, presence: true
end
