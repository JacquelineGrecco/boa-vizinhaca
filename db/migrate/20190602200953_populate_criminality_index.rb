class PopulateCriminalityIndex < ActiveRecord::Migration[5.2]
  def change
    Neighbour.all.each do |n|
      i = {
          robberies: n.occurrences.robberies.count.to_f * Occurrence.indexes[:robbery],
          thefts: n.occurrences.thefts.count.to_f * Occurrence.indexes[:theft],
          rapes: n.occurrences.rapes.count.to_f * Occurrence.indexes[:rape],
          assaults: n.occurrences.assaults.count.to_f * Occurrence.indexes[:assault],
          traffics: n.occurrences.traffics.count.to_f * Occurrence.indexes[:traffic],
      }

      n.criminality_index = i.values.sum / n.population_quantity.to_f

      n.save
    end
  end
end
