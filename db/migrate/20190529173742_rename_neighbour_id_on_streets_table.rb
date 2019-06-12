class RenameNeighbourIdOnStreetsTable < ActiveRecord::Migration[5.2]
  def change
    rename_column :streets, :neighbours_id, :neighbour_id
  end
end
