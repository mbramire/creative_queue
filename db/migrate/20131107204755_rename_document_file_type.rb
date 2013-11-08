class RenameDocumentFileType < ActiveRecord::Migration
  def change
    rename_column :virtuals, :document_file_type, :document_content_type
  end
end
