class AddCurrentToHistories < ActiveRecord::Migration[5.1]
  def change
    add_column :histories, :current, :integer
  end
end
