class CreateSavedprograms < ActiveRecord::Migration
  def change
    create_table :savedprograms do |t|
      t.references :program, index: true
      t.references :trainer, index: true

      t.timestamps null: false
    end
    add_foreign_key :savedprograms, :programs
    add_foreign_key :savedprograms, :trainers
  end
end
