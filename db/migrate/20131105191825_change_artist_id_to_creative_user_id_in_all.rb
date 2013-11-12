class ChangeArtistIdToCreativeUserIdInAll < ActiveRecord::Migration
  def change
    rename_column :virtuals, :artist_id, :creative_user_id
    rename_column :virtual_requests, :artist_id, :creative_user_id
  end
end
