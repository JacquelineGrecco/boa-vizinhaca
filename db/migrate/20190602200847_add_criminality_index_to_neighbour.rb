class AddCriminalityIndexToNeighbour < ActiveRecord::Migration[5.2]
  def change
    add_column :neighbours, :criminality_index, :decimal
  end
end
