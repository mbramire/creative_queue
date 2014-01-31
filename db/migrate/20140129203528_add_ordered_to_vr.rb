class AddOrderedToVr < ActiveRecord::Migration
  def change
    add_column :virtual_requests, :ordered, :boolean, default: false
  end
end
