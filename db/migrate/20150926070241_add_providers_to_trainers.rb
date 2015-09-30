class AddProvidersToTrainers < ActiveRecord::Migration
  def change
    add_column :trainers, :provider, :string
    add_column :trainers, :uid, :string
  end
end
