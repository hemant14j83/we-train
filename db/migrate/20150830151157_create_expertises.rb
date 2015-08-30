class CreateExpertises < ActiveRecord::Migration
  def change
    create_table :expertises do |t|
      t.string :expertise_in
      t.string :professional_expertise_info
      t.string :reference_name, :limit => 150
      t.string :reference_number, :limit => 15
      t.string :reference_email, :limit => 100
      t.string :expertise_verified_status, :default => "UnVerified"
      t.references :trainer, index: true

      t.timestamps null: false
    end
    add_foreign_key :expertises, :trainers
  end
end
