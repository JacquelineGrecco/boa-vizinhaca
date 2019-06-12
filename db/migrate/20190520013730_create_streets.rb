class CreateStreets < ActiveRecord::Migration[5.2]
  def change
    create_table :streets do |t|
      t.references :city, null: false
      t.string :name, null: false
      t.string :cep, null: false
      t.timestamps
    end
  end
end
