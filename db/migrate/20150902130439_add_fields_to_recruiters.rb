class AddFieldsToRecruiters < ActiveRecord::Migration
  def change
    add_column :recruiters, :firm_name, :string, :limit => 200
    add_column :recruiters, :firm_type, :string, :limit => 200, :default => "not selected"
    add_column :recruiters, :firm_number, :string, :limit => 15
    add_column :recruiters, :firm_address, :text
    add_column :recruiters, :city, :string
    add_column :recruiters, :state, :string
    add_column :recruiters, :country, :string
    add_column :recruiters, :pincode, :string, :limit => 6
    add_column :recruiters, :contact_person_name, :string, :limit =>150
    add_column :recruiters, :contact_person_email, :string
    add_column :recruiters, :contact_person_number, :string, :limit => 15
    add_column :recruiters, :subscribed_plan, :string, :default => "trail"
    add_column :recruiters, :account_status, :string, :default => "pending"
  end
end
