class CreateOccurrences < ActiveRecord::Migration[5.2]
  def change
    create_table :occurrences do |t|
      t.integer :kind, null: false
      t.string :zip_code, null: false
      t.timestamp :reported_at, null: false
      t.timestamps
    end
  end
end
