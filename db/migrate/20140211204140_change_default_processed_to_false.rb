class ChangeDefaultProcessedToFalse < ActiveRecord::Migration
  def change
    remove_column :virtual_requests, :processed 
    add_column :virtual_requests, :processed, :boolean, default: false
  end
end
