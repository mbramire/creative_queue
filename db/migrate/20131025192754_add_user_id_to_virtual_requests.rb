class AddUserIdToVirtualRequests < ActiveRecord::Migration
  def change
    add_column :virtual_requests, :user_id, :integer
  end
end
