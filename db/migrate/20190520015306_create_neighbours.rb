class CreateNeighbours < ActiveRecord::Migration[5.2]
  def change
    create_table :neighbours do |t|
      t.references :city, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
