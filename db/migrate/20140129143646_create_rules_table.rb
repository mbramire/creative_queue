class CreateRulesTable < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :company
      t.string :email
      t.string :name
    end

    add_index :virtual_requests, :processed
    add_index :virtual_requests, :completed
    add_index :virtual_requests, :creative_user_id
  end
end
