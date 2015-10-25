class CreateContactus < ActiveRecord::Migration
  def change
    create_table :contactus do |t|
      t.string :name
      t.string :email
      t.string :organisation
      t.string :title
      t.string :department
      t.string :phone
      t.string :city
      t.string :contact_type
      t.string :subject
      t.text :message
      
      t.timestamps null: false
    end
  end
end
