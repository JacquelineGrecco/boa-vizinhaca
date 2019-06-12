# frozen_string_literal: true

class AddForeignKeys < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key(:occurrences, :streets)
    add_foreign_key(:streets, :neighbours, column: :neighbours_id)
    add_foreign_key(:neighbours, :cities)
    add_foreign_key(:cities, :states)
  end
end
