class AddColumnToPageElements < ActiveRecord::Migration[5.2]
  def change
    add_reference :page_elements, :column, foreign_key: true
  end
end
