class CreateTrucks < ActiveRecord::Migration[5.1]
  def change
    create_table :trucks do |t|
      t.text :plate

      t.timestamps
    end
  end
end
