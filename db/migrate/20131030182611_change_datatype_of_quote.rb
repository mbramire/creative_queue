class ChangeDatatypeOfQuote < ActiveRecord::Migration
  def change
    remove_column :virtual_requests, :quote_number
    add_column :virtual_requests, :quote_number, :string
  end
end
