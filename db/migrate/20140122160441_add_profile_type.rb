class AddProfileType < ActiveRecord::Migration
  def change
    add_column :creative_users, :artist, :boolean
    add_column :creative_users, :sales, :boolean
    add_column :creative_users, :external, :boolean
  end
end
