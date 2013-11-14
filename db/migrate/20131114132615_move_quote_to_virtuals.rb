class MoveQuoteToVirtuals < ActiveRecord::Migration
  def change
    add_column :virtuals, :quote_number, :string
    remove_column :virtual_requests, :quote_number
    add_column :creative_users, :phone_number, :integer 
  end
end
