class RemoveForeignKeyColumnPageElements < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :page_elements, name: "fk_rails_dcddff817b"
  end
end
