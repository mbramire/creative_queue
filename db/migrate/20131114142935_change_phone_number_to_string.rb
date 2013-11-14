class ChangePhoneNumberToString < ActiveRecord::Migration
  def change
    remove_column :creative_users, :phone_number, :integer 
    add_column :creative_users, :phone_number, :string 
  end
end
