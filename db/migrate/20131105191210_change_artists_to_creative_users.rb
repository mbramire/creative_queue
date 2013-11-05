class ChangeArtistsToCreativeUsers < ActiveRecord::Migration
  def change
    rename_table :artists, :creative_users
  end
end
