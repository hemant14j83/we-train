class AddIndexToCategory < ActiveRecord::Migration
  def change
  	add_index :categories, :catable_id
  end
end

