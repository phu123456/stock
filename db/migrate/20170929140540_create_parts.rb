class CreateParts < ActiveRecord::Migration[5.1]
  def change
    create_table :parts do |t|
      t.text :name
      t.integer :quantity

      t.timestamps
    end
  end
end
