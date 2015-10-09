class CreateFunctions < ActiveRecord::Migration
  def change
    create_table :functions do |t|
      t.string :responsibility
      t.references :career, index: true

      t.timestamps null: false
    end
    add_foreign_key :functions, :careers
  end
end
