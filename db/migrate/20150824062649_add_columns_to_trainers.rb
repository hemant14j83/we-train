class AddColumnsToTrainers < ActiveRecord::Migration
  def change
    add_column :trainers, :login_type, :string, :limit => 80
    add_column :trainers, :full_name, :string, :limit => 150
    add_column :trainers, :primary_number, :string, :limit => 12 
    add_column :trainers, :birth_date, :date
    add_column :trainers, :gender, :string, :limit => 30, :default => "not selected"
    add_column :trainers, :address, :text
    add_column :trainers, :city, :string, :limit => 100
    add_column :trainers, :state, :string, :limit => 100
    add_column :trainers, :country, :string, :limit => 150
    add_column :trainers, :profile_status, :string, :limit => 100, :default => "pending"
    add_column :trainers, :subscribed_plan, :string, :limit => 100, :default => "trail"
    add_column :trainers, :busy_from, :date
    add_column :trainers, :busy_till, :date
  end
end
