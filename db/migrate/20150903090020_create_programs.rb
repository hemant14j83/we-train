class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name
      t.text :program_details
      t.string :duration, :limit=>100
      t.string :duration_type, :limit => 20
      t.string :payment_detail, :limit => 20
      t.string :payment_type, :limit => 20
      t.string :currency, :limit=>100, :default=> "INR"
      t.string :food_expense, :limit=>20, :default=>"No"
      t.string :food_expense_conditions
      t.string :travel_expense, :limit=>20, :default=>"No"
      t.text :travel_expense_conditions
      t.string :stay_expense, :limit=>20, :default=>"No"
      t.text :stay_expense_conditions
      t.date :start_date
      t.date :end_date
      t.text :venue
      t.string :city, :default => "not mentioned"
      t.string :state, :default => "not mentioned"
      t.string :country, :default => "India"
      t.references :recruiter, index: true

      t.timestamps null: false
    end
    add_foreign_key :programs, :recruiters
  end
end
