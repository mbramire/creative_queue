class ChangeInQueueColumn < ActiveRecord::Migration
  def change
    remove_column :creative_users, :in_queue
    add_column :creative_users, :in_queue, :boolean
  end
end
