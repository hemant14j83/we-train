class AddCommentsToExpertise < ActiveRecord::Migration
  def change
  	 add_column :expertises, :comments, :text
  	 add_column :trainers, :role, :string, :limit => 50
  end
end
