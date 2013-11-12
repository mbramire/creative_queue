class AddArtistIdToVirtualRequest < ActiveRecord::Migration
  def change
    add_column :virtual_requests, :artist_id, :integer

    add_index :virtual_requests, :artist_id
  end
end
