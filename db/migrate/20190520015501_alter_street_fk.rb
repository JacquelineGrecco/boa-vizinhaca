class AlterStreetFk < ActiveRecord::Migration[5.2]
  def change
    remove_reference :streets, :city
    add_reference :streets, :neighbours, null: false
  end
end
