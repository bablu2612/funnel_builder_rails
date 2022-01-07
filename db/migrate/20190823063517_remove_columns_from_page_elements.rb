class RemoveColumnsFromPageElements < ActiveRecord::Migration[5.2]
  def change
    remove_column :page_elements, :field_name, :string
    remove_column :page_elements, :field_type, :string
    remove_column :page_elements, :width, :string
    remove_column :page_elements, :height, :string
  end
end
