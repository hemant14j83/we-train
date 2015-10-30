class CreateAppliedprograms < ActiveRecord::Migration
  def change
    create_table :appliedprograms do |t|
      t.string :status, :limit=>50,:default=>'pending'
      t.references :trainer, index: true
      t.references :program, index: true

      t.timestamps null: false
    end
    add_foreign_key :appliedprograms, :trainers
    add_foreign_key :appliedprograms, :programs
  end
end
