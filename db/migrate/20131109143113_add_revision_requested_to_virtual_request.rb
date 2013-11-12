class AddRevisionRequestedToVirtualRequest < ActiveRecord::Migration
  def change
    add_column :virtual_requests, :revision_requested, :boolean
  end
end
