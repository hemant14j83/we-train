class AddColToAppliedprograms < ActiveRecord::Migration
  def change
    add_column :appliedprograms, :recruiter_id, :integer
  end
end
