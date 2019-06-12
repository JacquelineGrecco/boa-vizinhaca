# frozen_string_literal: true
require_relative 'bulk'

module Generators
  module_function
  def generate_occurrences_csv(scope: Neighbour.all)
    csv = "Bairro,Roubos,Furtos,Apreensões de droga,Estupro,Agressões"

    scope.each do |n|
      occurrences = [
          n.occurrences.robberies.count,
          n.occurrences.thefts.count,
          n.occurrences.traffics.count,
          n.occurrences.rapes.count,
          n.occurrences.assaults.count,
      ]
      csv = "#{csv}\n#{n.name},#{occurrences.join(",")}"
    end

    csv
  end
end
