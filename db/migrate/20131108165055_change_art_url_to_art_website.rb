class ChangeArtUrlToArtWebsite < ActiveRecord::Migration
  def change
    rename_column :virtual_requests, :art_url, :art_website
  end
end
