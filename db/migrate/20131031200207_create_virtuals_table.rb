class CreateVirtualsTable < ActiveRecord::Migration
  def change
    create_table :virtuals do |t|
      t.string  :document
      t.integer :document_file_size
      t.string  :document_file_type
      t.string  :artist_comments
      t.string  :user_comments
      t.string  :recipients
      t.boolean :sent
      t.integer :virtual_request_id
      t.integer :artist_id
      t.integer :version, default: 1

      t.timestamps
    end

    add_index :virtuals, :artist_id
    add_index :virtuals, :virtual_request_id
  end
end
