class AddSecondReferenceToExpertise < ActiveRecord::Migration
  def change
    add_column :expertises, :reference_name1, :string, :limit=>100
    add_column :expertises, :reference_number1, :string, :limit=>12
    add_column :expertises, :reference_email1, :string
  end
end
