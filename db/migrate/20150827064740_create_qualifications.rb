class CreateQualifications < ActiveRecord::Migration
  def change
    create_table :qualifications do |t|
      t.string :course_name, :limit => 150
      t.string :course_type, :limit => 200
      t.text :course_description
      t.date :start_date
      t.date :end_date
      t.string :duration, :limit => 100
      t.string :percentage, :limit => 100
      t.string :grade, :limit =>100
      t.references :trainer, index: true

      t.timestamps null: false
    end
    add_foreign_key :qualifications, :trainers
  end
end
