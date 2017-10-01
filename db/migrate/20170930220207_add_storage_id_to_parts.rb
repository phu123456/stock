class AddStorageIdToParts < ActiveRecord::Migration[5.1]
  def change
    add_column :parts, :storage_id, :integer
  end
end
