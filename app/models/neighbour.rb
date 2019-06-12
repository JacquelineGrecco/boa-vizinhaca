# frozen_string_literal: true

class Neighbour < ApplicationRecord
  belongs_to :city
  has_many :streets
  has_many :occurrences, through: :streets
  validates :name, presence: true

  scope :occurrences_asc, -> { order('occurrences_count asc') }
  scope :occurrences_desc, -> { order('occurrences_count desc') }

  def self.with_occurrence_count(kind = :all)
    query =
      joins(:occurrences)
      .select('"neighbours".*, count("occurrences".*) as occurrences_count')
      .group(:id)

    query = query.where(occurrences: { kind: kind }) unless kind == :all

    query
  end

  def criminal_index
    occurrences.robberies.count.to_f * 10000.0 / population_quantity.to_f
    +
    occurrences.thefts.count.to_f * 10000.0 / population_quantity.to_f
    +
    occurrences.traffics.count.to_f * 10000.0 / population_quantity.to_f
    +
    occurrences.rapes.count.to_f * 10000.0 / population_quantity.to_f
    +
    occurrences.assaults.count.to_f * 10000.0 / population_quantity.to_f
  end
end
