class AddPreviewIdToSections < ActiveRecord::Migration[5.2]
  def change
    add_reference :sections, :preview, foreign_key: true
  end
end
