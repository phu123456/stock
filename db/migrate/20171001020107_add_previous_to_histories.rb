class AddPreviousToHistories < ActiveRecord::Migration[5.1]
  def change
    add_column :histories, :previous, :integer
  end
end
