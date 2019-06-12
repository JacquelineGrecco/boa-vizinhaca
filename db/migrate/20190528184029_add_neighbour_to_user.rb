class AddNeighbourToUser < ActiveRecord::Migration[5.2]
  def change
    remove_reference :users, :streets
    add_reference :users, :neighbours, foreign_key: true
  end
end
