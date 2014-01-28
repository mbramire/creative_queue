class AddQuoteNumToVr < ActiveRecord::Migration
  def change
    add_column :virtual_requests, :quote, :integer

    add_index :virtual_requests, :quote
  end
end
