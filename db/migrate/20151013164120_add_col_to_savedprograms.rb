class AddColToSavedprograms < ActiveRecord::Migration
  def change
    add_column :savedprograms, :status, :string, :limit => 20, :default=>'active'
  end
end
