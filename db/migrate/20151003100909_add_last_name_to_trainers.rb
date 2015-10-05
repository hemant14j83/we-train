class AddLastNameToTrainers < ActiveRecord::Migration
  def change
    add_column :trainers, :last_name, :string, :limit=>150
  end
end
