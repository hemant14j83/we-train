class AddColToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :catable_id, :integer
    add_column :categories, :catable_type, :string
  end
end
