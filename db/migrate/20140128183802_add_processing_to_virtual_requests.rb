class AddProcessingToVirtualRequests < ActiveRecord::Migration
  def change
    add_column :virtual_requests, :processed, :boolean
  end
end
