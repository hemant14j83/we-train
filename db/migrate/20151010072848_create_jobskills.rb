class CreateJobskills < ActiveRecord::Migration
  def change
    create_table :jobskills do |t|
      t.string :skill
      t.references :career, index: true

      t.timestamps null: false
    end
    add_foreign_key :jobskills, :careers
  end
end
