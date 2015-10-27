class CreateExpertlists < ActiveRecord::Migration
  def change
    create_table :expertlists do |t|
      t.string :name
      t.references :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :expertlists, :categories
  end
end
