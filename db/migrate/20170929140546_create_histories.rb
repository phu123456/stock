class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.text :name
      t.integer :quantity
      t.date :update_date
      t.text :updater
      t.text :plate
      t.text :discription

      t.timestamps
    end
  end
end
