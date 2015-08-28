class AddCompletedFromToQualifications < ActiveRecord::Migration
  def change
	add_column :qualifications, :completed_from, :string
  end
end
