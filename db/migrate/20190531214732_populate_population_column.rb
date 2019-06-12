class PopulatePopulationColumn < ActiveRecord::Migration[5.2]
  def change
    r = (50_000..100_000).to_a
    Neighbour.all.each do |neighbour|
      neighbour.update(population_quantity: r.sample)
    end
  end
end
