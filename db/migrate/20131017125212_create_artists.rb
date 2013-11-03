class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string  :name
      t.string  :email
      t.string  :password_digest
      t.string  :remember_token
      t.boolean :admin
      t.string  :avatar

      t.timestamps
    end

    add_index :artists, :email, unique: true
    add_index :artists, :remember_token
  end
end
