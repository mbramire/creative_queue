class AddAsiToVirtualRequests < ActiveRecord::Migration
  def change
    add_column :virtual_requests, :asi_number, :integer
  end
end
