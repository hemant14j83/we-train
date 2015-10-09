class AddDepartmentToCareers < ActiveRecord::Migration
  def change
    add_column :careers, :department, :string, :limit=>100
  end
end
