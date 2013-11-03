class AddColumnsToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :in_queue, :boolean, default: true
    add_column :artists, :title, :string, default: "Greenhorn"
  end
end
