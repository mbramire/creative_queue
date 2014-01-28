class AddColumnsToVirtualRequest < ActiveRecord::Migration
  def change
    add_column :virtual_requests, :end_client, :string
  end
end
