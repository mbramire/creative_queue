class ChangeDataTypeOfArtistComments < ActiveRecord::Migration
  def change
    remove_column :virtuals, :artist_comments
    remove_column :virtuals, :user_comments

    add_column :virtuals, :user_comments, :text
    add_column :virtuals, :artist_comments, :text
  end
end
