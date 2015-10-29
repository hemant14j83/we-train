class AddColToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :category, :string, :limit => 150
    add_column :programs, :status, :string, :limit => 50, :default => "active"
    add_column :programs, :expertise, :string
    add_column :programs, :plan, :string, :limit=> 50, :default => "Free"
  end
end
