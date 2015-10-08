class CreateCareers < ActiveRecord::Migration
  def change
    create_table :careers do |t|
      t.string :position, :limit=>150
      t.text :description
      t.string :status, :default => 'Closed'

      t.timestamps null: false
    end
  end
end
