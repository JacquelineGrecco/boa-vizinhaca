class AssociateOccurrenceToStreet < ActiveRecord::Migration[5.2]
  def change
    remove_column :occurrences, :zip_code
    add_reference :occurrences, :street, null: false
  end
end
