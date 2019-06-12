class AddPopulationToNeighbour < ActiveRecord::Migration[5.2]
  def change
    add_column :neighbours, :population_quantity, :integer
  end
end
