class ChangeSentFromBooleanToTimedate < ActiveRecord::Migration
  def change
    remove_column :virtuals, :sent
    add_column :virtuals, :sent, :datetime
  end
end
