class AddCompletedToVirtualRequests < ActiveRecord::Migration
  def change
    add_column :virtual_requests, :completed, :boolean, default: false
  end
end
